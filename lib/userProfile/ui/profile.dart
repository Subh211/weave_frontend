import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
import 'package:weave_frontend/userUpdate/ui/updateUser.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_bloc.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_event.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_repository.dart';
import 'package:weave_frontend/usersFeed/ui/usersFeed.dart';


class OwnProfile extends StatefulWidget {

  const OwnProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OwnProfileState();
  }
}


class _OwnProfileState extends State<OwnProfile> {
  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Feed()),
    );
    return false;
  }
  
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: BlocBuilder<GetUserProfileBloc, GetUserProfileState>(
          builder: (context, state) {
            if (state is UserProfileInitial) {
              BlocProvider.of<GetUserProfileBloc>(context).add(FetchUserProfileEvent());
              return Center(child: ProcessIndicator());
            } else if (state is UserProfileLoading) {
              return Scaffold(
                body: Center(child: ProcessIndicator()),
              );
            } else if (state is UserProfileLoaded) {
              var profile = state.profile;
              var user = profile.user;
              var posts = profile.posts.posts;

              double screenHeight = MediaQuery.of(context).size.height;
              double screenWidth = MediaQuery.of(context).size.width;
              double iconSize = screenHeight * 0.03;


              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Weave',
                    style: GoogleFonts.clickerScript(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(165, 179, 158, 1),
                      fontSize: AppBar().preferredSize.height,
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: screenHeight * 0.16,
                            width: screenWidth * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(user.photoURL!),
                            ),
                          ),
                          Row(
                            children: [
                              profileText(primaryText: '${posts!.length}', secondaryText: '\nposts'),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              profileText(primaryText: '${profile.friendDetails!.following!.length}', secondaryText: '\nfollowings'),
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              profileText(primaryText: '${profile.friendDetails!.followers!.length}', secondaryText: '\nfollowers')
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.displayName,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(user.name,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              user.bio!,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: CustomTextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => UpdateUser())
                            );
                          },
                          showPencilIcon: true,
                          showBorder: false,
                          horizontalPadding: screenWidth * 0.26,
                          buttonText: 'Edit Profile',
                          screenHeight: screenHeight,
                          buttonHeight: screenHeight * 0.06,
                          fontSize: screenHeight * 0.022,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.squarePlus,
                                size: iconSize,
                                color: selectedIndex == 0 ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider(create: (context) => UserPostBloc(UserPostRepository())..add(FetchUserPosts()),
                                                child: OwnPosts(),
                                    ),

                            )
                          );
                        },
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                          ),
                          itemBuilder: (context, index) {
                            var post = posts[index];
                            return InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(post.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: posts.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );

            } else if (state is UserProfileError) {
              return Center(child: Text('Error loading profile: ${state.error}'));
            } else {
              return Center(child: Text('Unexpected state'));
            }
          },
        ),
    );
  }
}
















// class _OwnProfileState extends State<OwnProfile> {
//   int selectedIndex = 0; // State to track the selected icon index
//
//   @override
//   Widget build(BuildContext context) {
//     var profile = widget.profile;
//     var user = profile.user;
//     var posts = profile.posts.posts; // Assuming posts is a list of Post objects
//
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double iconSize = screenHeight * 0.03;
//
//     return Scaffold();
//   }







//
// return Scaffold(
// body: SingleChildScrollView(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Container(
// height: screenHeight * 0.16,
// width: screenWidth * 0.25,
// decoration: BoxDecoration(
// color: Colors.greenAccent.withOpacity(0.2),
// shape: BoxShape.circle,
// ),
// padding: EdgeInsets.all(12.0),
// child: CircleAvatar(
// radius: 50,
// backgroundImage: NetworkImage(user.photoURL),
// ),
// ),
// Row(
// children: [
// Text(
// '${posts.length}  \n Posts ',
// textAlign: TextAlign.center,
// ),
// SizedBox(
// width: screenWidth * 0.05,
// ),
// Text(
// '${profile.friendDetails.following.length}  \n followings ',
// textAlign: TextAlign.center,
// ),
// SizedBox(
// width: screenWidth * 0.05,
// ),
// Text(
// '${profile.friendDetails.followers.length}  \n followers ',
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ],
// ),
// Padding(
// padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(user.displayName),
// Text(user.name),
// Text(user.bio),
// ],
// ),
// ),
// SizedBox(height: screenHeight * 0.02),
// Center(
// child: CustomTextButton(
// onPressed: () {},
// showPencilIcon: true,
// showBorder: false,
// horizontalPadding: screenWidth * 0.26,
// buttonText: 'Edit Profile',
// screenHeight: screenHeight,
// buttonHeight: screenHeight * 0.06,
// fontSize: screenHeight * 0.022,
// ),
// ),
// SizedBox(height: screenHeight * 0.02),
// Padding(
// padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// IconButton(
// onPressed: () {
// setState(() {
// selectedIndex = 0;
// });
// },
// icon: FaIcon(
// FontAwesomeIcons.tableCells,
// size: iconSize,
// color: selectedIndex == 0 ? Colors.black : Colors.grey,
// ),
// ),
// IconButton(
// onPressed: () {
// setState(() {
// selectedIndex = 1;
// });
// },
// icon: FaIcon(
// FontAwesomeIcons.squarePlus,
// size: iconSize,
// color: selectedIndex == 1 ? Colors.black : Colors.grey,
// ),
// ),
// IconButton(
// onPressed: () {
// setState(() {
// selectedIndex = 2;
// });
// },
// icon: FaIcon(
// FontAwesomeIcons.bookmark,
// size: iconSize,
// color: selectedIndex == 2 ? Colors.black : Colors.grey,
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: screenHeight * 0.02),
// GridView.builder(
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 3,
// crossAxisSpacing: 3,
// mainAxisSpacing: 3,
// ),
// itemBuilder: (context, index) {
// var post = posts[index];
// return InkWell(
// // onTap: () {
// //   Navigator.push(
// //     context,
// //     MaterialPageRoute(builder: (context) => SinglePost(post: post)),
// //   );
// // },
// child: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(post.image),
// fit: BoxFit.cover,
// ),
// ),
// ),
// );
// },
// itemCount: posts.length,
// ),
// ],
// ),
// ),
// );