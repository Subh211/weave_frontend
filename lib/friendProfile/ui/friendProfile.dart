import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_bloc.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_event.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_state.dart';
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_bloc.dart';
import 'package:weave_frontend/friendsFeed/bloc/friendsFeed_event.dart';
import 'package:weave_frontend/friendsFeed/ui/friendsFeed.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class FriendProfile extends StatefulWidget {
  final String friendId;

  const FriendProfile({
    Key? key,
    required this.friendId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _friendProfileState();
  }
}

class _friendProfileState extends State<FriendProfile> {
  int selectedIndex = 0;
  late ValueNotifier<int> followersNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize the ValueNotifier with a default value
    followersNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    // Dispose the ValueNotifier to avoid memory leaks
    followersNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFriendProfileBloc, GetFriendProfileState>(
      builder: (context, state) {
        if (state is FriendProfileInitial) {
          BlocProvider.of<GetFriendProfileBloc>(context)
              .add(FetchFriendProfileEvent(friendId: widget.friendId));
          return Center(child: ProcessIndicator());
        } else if (state is FriendProfileLoading) {
          return Scaffold(
            body: Center(child: ProcessIndicator()),
          );
        } else if (state is FriendProfileLoaded) {
          var profile = state.profile;
          var user = profile.user;
          var posts = profile.posts.posts;
          var isFriend = profile.isFriend;

          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;
          double iconSize = screenHeight * 0.03;

          followersNotifier.value = profile.friendDetails.followers.length;

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
                          backgroundImage: NetworkImage(user.photoURL),
                        ),
                      ),
                      Row(
                        children: [
                          profileText(primaryText: '${posts.length}', secondaryText: '\nposts'),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          profileText(primaryText: '${profile.friendDetails.following.length}', secondaryText: '\nfollowings'),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          ValueListenableBuilder<int>(
                              valueListenable: followersNotifier,
                              builder:(context,followersCount,child) {
                                return profileText(primaryText: '$followersCount', secondaryText: '\nfollowers');
                              }
                          ),
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
                        Text(user.bio,
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
                    child: CustomTextButtonForFriend(
                      onPressed: () {},
                      onFollowersStatusChanged: (isFriend) {
                        if (isFriend) {
                          followersNotifier.value -= 1;
                        } else {
                          followersNotifier.value += 1;
                        }
                      },
                      showPencilIcon: false,
                      showBorder: false,
                      horizontalPadding: screenWidth * 0.26,
                      screenHeight: screenHeight,
                      buttonHeight: screenHeight * 0.06,
                      fontSize: screenHeight * 0.022,
                      isFriend: isFriend,
                      friendId: user.id,
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
                                BlocProvider(create: (context) => FriendPostBloc()..add(FetchFriendPosts(friendId: user.id )),
                                  child: FriendPosts(friendId: user.id),
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
        } else if (state is FriendProfileError) {
          return Center(child: Text('Error loading profile: ${state.error}'));
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}










