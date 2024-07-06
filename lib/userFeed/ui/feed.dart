// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_bloc.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
// import 'package:weave_frontend/allUser/ui/allUser.dart';
// import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
// import 'package:weave_frontend/searchUser/ui/searchUser.dart';
// import 'package:weave_frontend/userAddPost/ui/addPost.dart';
// import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
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
//   bool _profileFetched = false;
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
//       Posts(),
//       BlocProvider(
//         create: (context) => AlluserBloc(),
//           //..add(SearchAllUser(searchTerm: '')),
//         child: SearchUser(),
//       ),
//       BlocProvider(
//         create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
//         child: AddPost(),
//       ),
//       BlocProvider(
//         create: (context) => AlluserBloc()..add(GetAllUser()),
//         child: AllUser(),
//       ),
//       BlocProvider(
//         create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//         child: OwnProfile(),
//       ),
//     ];
//   }
//
//   void _onItemTapped(int index) async {
//     final token = await _getToken;
//     if (token != null && index == 2 && !_profileFetched) {
//       print("Fetching user profile...");
//       BlocProvider.of<GetUserProfileBloc>(context).add(FetchUserProfileEvent());
//       setState(() {
//         _profileFetched = true;
//       });
//     }
//     if (index == 1) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BlocProvider(
//             create: (context) => AlluserBloc(),
//             child: SearchUser(),
//           ))
//       );
//     }
//     if (index == 3) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => BlocProvider(
//           create: (context) => AlluserBloc()..add(GetAllUser()),
//           child: AllUser(),
//         ))
//       );
//     }
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     if (index == 4) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BlocProvider(
//             create: (context) => GetUserProfileBloc(getUserProfileRepository, token!),
//             child: OwnProfile(),
//           ))
//       );
//     }
//     if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AddPost()),
//       );
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
//       automaticallyImplyLeading: false,
//       actions: [
//         // IconButton(
//         //   icon: FaIcon(FontAwesomeIcons.bell),
//         //   onPressed: () {},
//         // ),
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
//             return MultiBlocProvider(
//               providers: [
//                 BlocProvider(
//                   create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//                 ),
//               ],
//               child: Scaffold(
//                 appBar: appBar,
//                 body: _widgetOptions(token).elementAt(_selectedIndex),
//                 bottomNavigationBar: BottomAppBar(
//                   color: Colors.transparent,
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
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.group,
//                           color: _selectedIndex == 3 ? Colors.black : Colors.grey,
//                         ),
//                         onPressed: () => _onItemTapped(3),
//                       ),
//                       IconButton(
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundImage: AssetImage('assests/images/profileimage.png'),
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
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_bloc.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
// import 'package:weave_frontend/allUser/ui/allUser.dart';
// import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
// import 'package:weave_frontend/searchUser/ui/searchUser.dart';
// import 'package:weave_frontend/userAddPost/ui/addPost.dart';
// import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
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
//   bool _profileFetched = false;
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
//       Posts(),
//       BlocProvider(
//         create: (context) => AlluserBloc(),
//         child: SearchUser(),
//       ),
//       BlocProvider(
//         create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
//         child: AddPost(),
//       ),
//       BlocProvider(
//         create: (context) => AlluserBloc()..add(GetAllUser()),
//         child: AllUser(),
//       ),
//       BlocProvider(
//         create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//         child: OwnProfile(),
//       ),
//     ];
//   }
//
//   void _onItemTapped(int index) async {
//     final token = await _getToken;
//
//     setState(() {
//       _selectedIndex = index;
//     });
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
//       automaticallyImplyLeading: false,
//       actions: [
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
//             return MultiBlocProvider(
//               providers: [
//                 BlocProvider(
//                   create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//                 ),
//               ],
//               child: Scaffold(
//                 appBar: appBar,
//                 body: _widgetOptions(token).elementAt(_selectedIndex),
//                 bottomNavigationBar: BottomAppBar(
//                   color: Colors.transparent,
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
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.group,
//                           color: _selectedIndex == 3 ? Colors.black : Colors.grey,
//                         ),
//                         onPressed: () => _onItemTapped(3),
//                       ),
//                       IconButton(
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundImage: AssetImage('assests/images/profileimage.png'),
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
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_bloc.dart';
// import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
// import 'package:weave_frontend/allUser/ui/allUser.dart';
// import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
// import 'package:weave_frontend/searchUser/ui/searchUser.dart';
// import 'package:weave_frontend/userAddPost/ui/addPost.dart';
// import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
// import 'package:weave_frontend/userProfile/ui/profile.dart';
// import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class Feed extends StatefulWidget {
//
//   @override
//   State<StatefulWidget> createState() => _FeedState();
// }
//
// class _FeedState extends State<Feed> {
//   final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
//   int _selectedIndex = 0;
//   late Future<String?> _getToken;
//   bool _profileFetched = false;
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
//   void _onItemTapped(int index) async {
//     final token = await _getToken;
//
//     // setState(() {
//     //   _selectedIndex = index;
//     // });
//
//     if (index == 4) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BlocProvider(
//             create: (context) => GetUserProfileBloc(getUserProfileRepository, token!),
//             child: OwnProfile(),
//           ),
//         ),
//       );
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }
//
//   Future<bool> _onWillPop() async {
//     if (_selectedIndex != 0) {
//       setState(() {
//         _selectedIndex = 0;
//       });
//       return false; // Do not pop the route
//     } else if (_selectedIndex == 0) {
//       SystemNavigator.pop();
//       return false;
//     } else {
//       return false;
//     }
//   }
//
//   List<Widget> _widgetOptions(String token) {
//     return <Widget>[
//       Posts(),
//       BlocProvider(
//         create: (context) => AlluserBloc(),
//         child: SearchUser(),
//       ),
//       BlocProvider(
//         create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
//         child: AddPost(),
//       ),
//       BlocProvider(
//         create: (context) => AlluserBloc()..add(GetAllUser()),
//         child: AllUser(),
//       ),
//       BlocProvider(
//         create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//         child: OwnProfile(),
//       ),
//     ];
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
//       automaticallyImplyLeading: false,
//       actions: [
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
//             return MultiBlocProvider(
//               providers: [
//                 BlocProvider(
//                   create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//                 ),
//               ],
//               child: WillPopScope(
//                 onWillPop: _onWillPop,
//                 child: Scaffold(
//                   appBar: appBar,
//                   body: _widgetOptions(token).elementAt(_selectedIndex),
//                   bottomNavigationBar: BottomAppBar(
//                     color: Colors.transparent,
//                     shape: CircularNotchedRectangle(),
//                     notchMargin: 10.0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(
//                             Icons.home,
//                             color: _selectedIndex == 0 ? Colors.black : Colors.grey,
//                           ),
//                           onPressed: () => _onItemTapped(0),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.search,
//                             color: _selectedIndex == 1 ? Colors.black : Colors.grey,
//                           ),
//                           onPressed: () => _onItemTapped(1),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             return _onItemTapped(2);
//                           },
//                           style: TextButton.styleFrom(
//                             backgroundColor: Color(0xFFC3B0E7),
//                             padding: EdgeInsets.all(15),
//                             shape: CircleBorder(),
//                             shadowColor: Colors.black,
//                             elevation: 10,
//                           ),
//                           child: SizedBox(
//                             width: 35,
//                             height: 35,
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: FaIcon(
//                                 FontAwesomeIcons.plus,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             Icons.group,
//                             color: _selectedIndex == 3 ? Colors.black : Colors.grey,
//                           ),
//                           onPressed: () => _onItemTapped(3),
//                         ),
//                         IconButton(
//                           icon: CircleAvatar(
//                             radius: 15,
//                             backgroundImage: AssetImage('assests/images/profileimage.png'),
//                           ),
//                           onPressed: () {
//                             _onItemTapped(4);
//                           },
//                         ),
//                       ],
//                     ),
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












import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weave_frontend/allUser/bloc/allUser_bloc.dart';
import 'package:weave_frontend/allUser/bloc/allUser_event.dart';
import 'package:weave_frontend/allUser/ui/allUser.dart';
import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
import 'package:weave_frontend/searchUser/ui/searchUser.dart';
import 'package:weave_frontend/userAddPost/ui/addPost.dart';
import 'package:weave_frontend/userAddPost/bloc/addPost_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
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

  late AlluserBloc allUserBloc;
  late AlluserBloc searchUserBloc;

  @override
  void initState() {
    super.initState();
    _getToken = _retrieveToken();
    allUserBloc = AlluserBloc();
    searchUserBloc = AlluserBloc();
  }

  Future<String?> _retrieveToken() async {
    return await FlutterSecureStorage().read(key: 'token');
  }

  void _onItemTapped(int index) async {
    final token = await _getToken;

    if (index == 4) {
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
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false; // Do not pop the route
    } else if (_selectedIndex == 0) {
      SystemNavigator.pop();
      return false;
    } else {
      return false;
    }
  }

  List<Widget> _widgetOptions(String token) {
    return <Widget>[
      Posts(),
      BlocProvider.value(
        value: searchUserBloc,
        child: SearchUser(),
      ),
      BlocProvider(
        create: (context) => AddPostBloc('https://weave-backend-pyfu.onrender.com', token),
        child: AddPost(),
      ),
      BlocProvider.value(
        value: allUserBloc..add(GetAllUser()),
        child: AllUser(),
      ),
      BlocProvider(
        create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
        child: OwnProfile(),
      ),
    ];
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
      automaticallyImplyLeading: false,
      actions: [
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
              child: WillPopScope(
                onWillPop: _onWillPop,
                child: Scaffold(
                  appBar: appBar,
                  body: _widgetOptions(token).elementAt(_selectedIndex),
                  bottomNavigationBar: BottomAppBar(
                    color: Colors.transparent,
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
                                color: Colors.white,
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
                            backgroundImage: AssetImage('assests/images/profileimage.png'),
                          ),
                          onPressed: () {
                            _onItemTapped(4);
                          },
                        ),
                      ],
                    ),
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

