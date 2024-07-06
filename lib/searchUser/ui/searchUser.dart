import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/allUser/bloc/allUser_bloc.dart';
import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
import 'package:weave_frontend/allUser/bloc/allUser_state.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_bloc.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_event.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_repository.dart';
import 'package:weave_frontend/friendProfile/ui/friendProfile.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
import 'package:weave_frontend/userProfile/ui/profile.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';
import 'package:google_fonts/google_fonts.dart';


class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  GetFriendProfileRepository getFriendProfileRepository = GetFriendProfileRepository();
  final TextEditingController searchController = TextEditingController();
  GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
  late Future<String?> _getToken = _retrieveToken();
  @override
  void initState() {
    super.initState();
    _getToken = _retrieveToken();
  }

  Future<String?> _retrieveToken() async {
    return await FlutterSecureStorage().read(key: 'token');
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10.0),
          textFields(
              screenHeight: MediaQuery.of(context).size.width * 0.1,
              screenWidth: MediaQuery.of(context).size.height * 0.8,
              hintText: "Search",
              controller: searchController,
          ),
          IconButton(
              onPressed: () {
                String searchText = searchController.text.trim();
                context.read<AlluserBloc>().add(SearchAllUser(searchTerm: searchText));
          },
              icon: Icon(Icons.search))
        ],
      ),
      automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AlluserBloc,AlluserState> (
        builder: (context,state) {
          if (state is AlluserStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AlluserStateLoaded) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context,index) {
                  final user = state.users[index];
                  return SingleChildScrollView(
                    child:InkWell(
                      onTap: () async{
                        final token = await _retrieveToken();
                        if (user.username == user.displayName) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => GetUserProfileBloc(getUserProfileRepository, token!),
                                child: OwnProfile(),
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => GetFriendProfileBloc(getFriendProfileRepository)
                                  ..add(FetchFriendProfileEvent(friendId: user.id)),
                                child: FriendProfile(friendId: user.id),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.075,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.0),
                              CircleAvatar(
                                radius: 29.0, // Adjust this value to change the size
                                backgroundImage: NetworkImage(user.photoURL),
                                //backgroundImage: AssetImage("assests/images/vk2.jpeg"),
                              ),
                              SizedBox(width: 10.0), // Adding some space between avatar and text
                              Text(
                                user.displayName,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height*0.018,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else if (state is AlluserStateError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No user available'));
        },
      ),
    );
  }
}



