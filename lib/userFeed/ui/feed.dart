// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
// import 'package:weave_frontend/userAddPost/ui/addPost.dart';
// import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
// import 'package:weave_frontend/userProfile/ui/profile.dart';
// import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class Feed extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _FeedState();
// }
//
// class _FeedState extends State<Feed> {
//   final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
//   int _selectedIndex = 0;
//
//   late Future<String?> _getToken;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _getToken = _retrieveToken();
//   }
//
//   Future<String?> _retrieveToken() async {
//     return await FlutterSecureStorage().read(key: 'token');
//   }
//
//   List<Widget> _widgetOptions(String token) {
//     return <Widget>[
//       Posts(), // Index 0
//       Profile(), // Index 1 - You can replace Placeholder() with the desired widget for index 1
//       BlocProvider(
//         create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
//         child: AddPost(),
//       ), // Index 2 - AddPost with BlocProvider
//       Posts(), // Index 3 - You can replace Placeholder() with the desired widget for index 2
//       // BlocProvider(
//       //   create: (context) => GetUserProfileBloc(token),
//       //   child: Profile(),
//       // ),Index 4 - You can replace Placeholder() with the desired widget for index 3
//       BlocProvider(
//       create: (context) => GetUserProfileBloc(getUserProfileRepository,token)..add(FetchUserProfileEvent()),
//       child: Profile(),)
//
//     ];
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     // Navigate to Page when index is 2 (plus button)
//     if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AddPost()),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(
//       title: Text(
//         'Weave',
//         style: GoogleFonts.clickerScript(
//           fontWeight: FontWeight.w600,
//           color: Color.fromRGBO(165, 179, 158, 1),
//           fontSize: AppBar().preferredSize.height,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: FaIcon(FontAwesomeIcons.bell),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: FaIcon(FontAwesomeIcons.bars),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen()));
//           },
//         ),
//       ],
//     );
//
//     return FutureBuilder<String?>(
//       future: _getToken,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           final token = snapshot.data;
//           if (token != null) {
//             return Scaffold(
//               appBar: appBar,
//               body: _widgetOptions(token).elementAt(_selectedIndex),
//               bottomNavigationBar: BottomAppBar(
//                 color: Colors.white,
//                 shape: CircularNotchedRectangle(),
//                 notchMargin: 10.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(
//                         Icons.home,
//                         color: _selectedIndex == 0 ? Colors.black : Colors.grey,
//                       ),
//                       onPressed: () => _onItemTapped(0),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.search,
//                         color: _selectedIndex == 1 ? Colors.black : Colors.grey,
//                       ),
//                       onPressed: () => _onItemTapped(1),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         return _onItemTapped(2);
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: Color(0xFFC3B0E7),
//                         padding: EdgeInsets.all(15), // Reduce padding to make the button smaller
//                         shape: CircleBorder(), // Use CircleBorder to create a circular shape
//                         shadowColor: Colors.black, // Shadow color
//                         elevation: 10, // Elevation
//                       ),
//                       child: SizedBox(
//                         width: 35, // Set a fixed width for the button
//                         height: 35, // Set a fixed height for the button
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: FaIcon(
//                             FontAwesomeIcons.plus,
//                             color: Colors.purple,
//                             size: 20, // Adjust icon size as needed
//                           ),
//                         ),
//                       ),
//                     ),
//                     // The dummy child for spacing
//                     IconButton(
//                       icon: Icon(
//                         Icons.group,
//                         color: _selectedIndex == 2 ? Colors.black : Colors.grey,
//                       ),
//                       onPressed: () => _onItemTapped(3),
//                     ),
//                     IconButton(
//                       icon: CircleAvatar(
//                         radius: 15,
//                         backgroundImage: AssetImage('assests/images/vk2.jpeg'),
//                       ),
//                        onPressed: ()  {
//                            _onItemTapped(4);
//                        },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Center(child: Text('Token retrieval failed.'));
//           }
//         }
//       },
//     );
//   }
// }
//
//
//
//





// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
// import 'package:weave_frontend/userAddPost/ui/addPost.dart';
// import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
// import 'package:weave_frontend/userProfile/ui/profile.dart';
// import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
//
//
// class Feed extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _FeedState();
// }
//
// class _FeedState extends State<Feed> {
//   final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
//   int _selectedIndex = 0;
//
//   late Future<String?> _getToken;
//
//   @override
//   void initState() {
//     super.initState();
//     _getToken = _retrieveToken();
//   }
//
//   Future<String?> _retrieveToken() async {
//     return await FlutterSecureStorage().read(key: 'token');
//   }
//
//   List<Widget> _widgetOptions(String token) {
//     return <Widget>[
//       Posts(), // Index 0
//       Profile(), // Index 1
//       BlocProvider(
//         create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
//         child: AddPost(),
//       ), // Index 2
//       Posts(), // Index 3
//       BlocBuilder<GetUserProfileBloc, GetUserProfileState>(
//         builder: (context, state) {
//           if (state is UserProfileLoaded) {
//             return Profile(); // Replace with your Profile widget
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),// Index 4
//     ];
//   }
//
//   void _onItemTapped(int index) async {
//     if (index == 4) {
//       final token = await _getToken;
//       if (token != null) {
//         BlocProvider.of<GetUserProfileBloc>(context).add(FetchUserProfileEvent());
//       }
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//
//       if (index == 2) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddPost()),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(
//       title: Text(
//         'Weave',
//         style: GoogleFonts.clickerScript(
//           fontWeight: FontWeight.w600,
//           color: Color.fromRGBO(165, 179, 158, 1),
//           fontSize: AppBar().preferredSize.height,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: FaIcon(FontAwesomeIcons.bell),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: FaIcon(FontAwesomeIcons.bars),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen()));
//           },
//         ),
//       ],
//     );
//
//     return FutureBuilder<String?>(
//       future: _getToken,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           final token = snapshot.data;
//           if (token != null) {
//             return Scaffold(
//               appBar: appBar,
//               body: _widgetOptions(token).elementAt(_selectedIndex),
//               bottomNavigationBar: BottomAppBar(
//                 color: Colors.white,
//                 shape: CircularNotchedRectangle(),
//                 notchMargin: 10.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(
//                         Icons.home,
//                         color: _selectedIndex == 0 ? Colors.black : Colors.grey,
//                       ),
//                       onPressed: () => _onItemTapped(0),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.search,
//                         color: _selectedIndex == 1 ? Colors.black : Colors.grey,
//                       ),
//                       onPressed: () => _onItemTapped(1),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         return _onItemTapped(2);
//                       },
//                       style: TextButton.styleFrom(
//                         backgroundColor: Color(0xFFC3B0E7),
//                         padding: EdgeInsets.all(15),
//                         shape: CircleBorder(),
//                         shadowColor: Colors.black,
//                         elevation: 10,
//                       ),
//                       child: SizedBox(
//                         width: 35,
//                         height: 35,
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: FaIcon(
//                             FontAwesomeIcons.plus,
//                             color: Colors.purple,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.group,
//                         color: _selectedIndex == 2 ? Colors.black : Colors.grey,
//                       ),
//                       onPressed: () => _onItemTapped(3),
//                     ),
//                     IconButton(
//                       icon: CircleAvatar(
//                         radius: 15,
//                         backgroundImage: AssetImage('assests/images/vk2.jpeg'),
//                       ),
//                       onPressed: () {
//                         _onItemTapped(4);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Center(child: Text('Token retrieval failed.'));
//           }
//         }
//       },
//     );
//   }
// }
















//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:weave_frontend/models/profileModel.dart';
// import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
// import 'package:weave_frontend/userAddPost/ui/addPost.dart';
// import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
// import 'package:weave_frontend/userProfile/ui/profile.dart';
// import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class Feed extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _FeedState();
// }
//
// class _FeedState extends State<Feed> {
//   final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
//   int _selectedIndex = 0;
//   late Future<String?> _getToken;
//   late GetUserProfileBloc _getUserProfileBloc;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _getToken = _retrieveToken();
//   }
//
//   Future<String?> _retrieveToken() async {
//     return await FlutterSecureStorage().read(key: 'token');
//   }
//
//   List<Widget> _widgetOptions(String token) {
//     return <Widget>[
//       Posts(), // Index 0
//       Posts(), // Index 1
//       BlocProvider(
//         create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
//         child: AddPost(),
//       ), // Index 2
//       Posts(), // Index 3
//       BlocBuilder<GetUserProfileBloc, GetUserProfileState>(
//         builder: (context, state) {
//           if (state is UserProfileLoaded) {
//             return OwnProfile(profile: state.profile); // Replace with your Profile widget
//           } else if (state is UserProfileError) {
//             return Center(child: Text('Error: ${state.error}'));
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ), // Index 4
//     ];
//   }
//
//   void _onItemTapped(int index) async {
//     if (index == 4) {
//       final token = await _getToken;
//       if (token != null) {
//         _getUserProfileBloc.add(FetchUserProfileEvent());
//         // BlocProvider.of<GetUserProfileBloc>(context).add(FetchUserProfileEvent());
//       }
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//
//       if (index == 2) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddPost()),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(
//       title: Text(
//         'Weave',
//         style: GoogleFonts.clickerScript(
//           fontWeight: FontWeight.w600,
//           color: Color.fromRGBO(165, 179, 158, 1),
//           fontSize: AppBar().preferredSize.height,
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: FaIcon(FontAwesomeIcons.bell),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: FaIcon(FontAwesomeIcons.bars),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen()));
//           },
//         ),
//       ],
//     );
//
//     return FutureBuilder<String?>(
//       future: _getToken,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           final token = snapshot.data;
//           if (token != null) {
//             return BlocProvider(
//               create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//               child: Scaffold(
//                 appBar: appBar,
//                 body: _widgetOptions(token).elementAt(_selectedIndex),
//                 bottomNavigationBar: BottomAppBar(
//                   color: Colors.white,
//                   shape: CircularNotchedRectangle(),
//                   notchMargin: 10.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(
//                           Icons.home,
//                           color: _selectedIndex == 0 ? Colors.black : Colors.grey,
//                         ),
//                         onPressed: () => _onItemTapped(0),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.search,
//                           color: _selectedIndex == 1 ? Colors.black : Colors.grey,
//                         ),
//                         onPressed: () => _onItemTapped(1),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           return _onItemTapped(2);
//                         },
//                         style: TextButton.styleFrom(
//                           backgroundColor: Color(0xFFC3B0E7),
//                           padding: EdgeInsets.all(15),
//                           shape: CircleBorder(),
//                           shadowColor: Colors.black,
//                           elevation: 10,
//                         ),
//                         child: SizedBox(
//                           width: 35,
//                           height: 35,
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: FaIcon(
//                               FontAwesomeIcons.plus,
//                               color: Colors.purple,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.group,
//                           color: _selectedIndex == 2 ? Colors.black : Colors.grey,
//                         ),
//                         onPressed: () => _onItemTapped(3),
//                       ),
//                       IconButton(
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundImage: AssetImage('assests/images/vk2.jpeg'),
//                         ),
//                         onPressed: () {
//                           _onItemTapped(4);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Center(child: Text('Token retrieval failed.'));
//           }
//         }
//       },
//     );
//   }
// }
//
//
//
//






import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weave_frontend/models/profileModel.dart';
import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
import 'package:weave_frontend/userAddPost/ui/addPost.dart';
import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
import 'package:weave_frontend/userProfile/ui/profile.dart';
import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Feed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
  int _selectedIndex = 0;
  late Future<String?> _getToken;
  bool _profileFetched = false;

  @override
  void initState() {
    super.initState();
    _getToken = _retrieveToken();
  }

  Future<String?> _retrieveToken() async {
    return await FlutterSecureStorage().read(key: 'token');
  }

  List<Widget> _widgetOptions(String token) {
    return <Widget>[
      Posts(), // Index 0
      Posts(), // Index 1
      BlocProvider(
        create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
        child: AddPost(),
      ), // Index 2
      Posts(), // Index 3
      BlocProvider(
        create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
        child: OwnProfile(), // Replace with your Profile widget
      ), // Index 4
    ];
  }

  void _onItemTapped(int index) async {
    final token = await _getToken;
    if (token != null && index == 4 && !_profileFetched) {
      print("Fetching user profile...");
      BlocProvider.of<GetUserProfileBloc>(context).add(FetchUserProfileEvent());
      setState(() {
        _profileFetched = true;
      });
    }
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPost()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Weave',
        style: GoogleFonts.clickerScript(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(165, 179, 158, 1),
          fontSize: AppBar().preferredSize.height,
        ),
      ),
      actions: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.bell),
          onPressed: () {},
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.bars),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen()));
          },
        ),
      ],
    );

    return FutureBuilder<String?>(
      future: _getToken,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final token = snapshot.data;
          if (token != null) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
                ),
              ],
              child: Scaffold(
                appBar: appBar,
                body: _widgetOptions(token).elementAt(_selectedIndex),
                bottomNavigationBar: BottomAppBar(
                  color: Colors.white,
                  shape: CircularNotchedRectangle(),
                  notchMargin: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                        ),
                        onPressed: () => _onItemTapped(0),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                        ),
                        onPressed: () => _onItemTapped(1),
                      ),
                      TextButton(
                        onPressed: () {
                          return _onItemTapped(2);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFC3B0E7),
                          padding: EdgeInsets.all(15),
                          shape: CircleBorder(),
                          shadowColor: Colors.black,
                          elevation: 10,
                        ),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Align(
                            alignment: Alignment.center,
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              color: Colors.purple,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.group,
                          color: _selectedIndex == 3 ? Colors.black : Colors.grey,
                        ),
                        onPressed: () => _onItemTapped(3),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage('assests/images/vk2.jpeg'),
                        ),
                        onPressed: () {
                          _onItemTapped(4);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('Token retrieval failed.'));
          }
        }
      },
    );
  }
}
