import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/allUser/bloc/allUser_bloc.dart';
import 'package:weave_frontend/allUser/bloc/allUser_state.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_bloc.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_event.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_repository.dart';
import 'package:weave_frontend/friendProfile/ui/friendProfile.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
import 'package:weave_frontend/userProfile/ui/profile.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class AllUser extends StatefulWidget {
  const AllUser({super.key});

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  GetFriendProfileRepository getFriendProfileRepository = GetFriendProfileRepository();
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

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop(true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('All Users', style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w500
            )),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<AlluserBloc, AlluserState> (
          builder: (context, state) {
            if (state is AlluserStateLoading) {
              return Center(child: ProcessIndicator());
            } else if (state is AlluserStateLoaded) {
              return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return SingleChildScrollView(
                      child: InkWell(
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
                            minHeight: screenHeight * 0.075,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.0),
                                CircleAvatar(
                                  radius: 29.0,
                                  backgroundImage: NetworkImage(user.photoURL),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  user.displayName,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: screenHeight * 0.018,
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
                  }
              );
            } else if (state is AlluserStateError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Center(child: Text('No User found'));
          },
        ),
      ),
    );
  }
}

