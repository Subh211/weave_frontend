// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:weave_frontend/userDelete/bloc/deleteUser_bloc.dart';
// import 'package:weave_frontend/userDelete/bloc/deleteUser_state.dart';
// import 'package:weave_frontend/userFeed/ui/feed.dart';
// import 'package:weave_frontend/userSignUp/ui/userSignUp.dart';
// import 'package:weave_frontend/userUpdate/bloc/userUpdate_bloc.dart';
// import 'package:weave_frontend/userUpdate/bloc/userUpdate_event.dart';
// import 'package:weave_frontend/userUpdate/bloc/userUpdate_state.dart';
// import 'package:weave_frontend/user_essestials/userEssentials.dart';
//
// import '../bloc/deleteUser_event.dart';
//
// class DeleteUser extends StatefulWidget {
//   @override
//   _DeleteUserState createState() => _DeleteUserState();
// }
//
// class _DeleteUserState extends State<DeleteUser> {
//   final TextEditingController passwordController = TextEditingController();
//
//   late Future<String?> _getToken = _retrieveToken();
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
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: FutureBuilder<String?>(
//         future: _getToken,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             final token = snapshot.data;
//             if (token != null) {
//               return BlocProvider(
//                 create: (context) => UpdateUserBloc('https://weave-backend-pyfu.onrender.com', token),
//                 child: BlocListener<DeleteUserBloc, DeleteUserState>(
//                   listener: (context, state) {
//                     if (state is DeleteUserSuccess) {
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text(state.message)));
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Feed()),
//                       );
//                     } else if (state is UpdateUserFailure) {
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text("Unable to delete")));
//                     }
//                   },
//                   child: BlocBuilder<DeleteUserBloc, DeleteUserState>(
//                     builder: (context, state) {
//                       if (state is DeleteUserLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       return SingleChildScrollView(
//                         child: Container(
//                           height: screenHeight,
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 flex: 10,
//                                 child: weaveText(
//                                   screenHeight: screenHeight,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 0,
//                                 child: Container(),
//                               ),
//                               Expanded(
//                                   flex: 25,
//                                   child: Container(
//                                     child: Stack(
//                                       clipBehavior: Clip.none,
//                                       children: [
//                                         Container(
//                                           height: screenWidth * 0.87,
//                                           width: screenWidth * 0.87,
//                                           decoration: BoxDecoration(
//                                             color: Colors.transparent,
//                                             borderRadius:
//                                             BorderRadius.all(Radius.circular(35)),
//                                             border: Border.all(
//                                               color: Colors.black,
//                                               width: 0.8,
//                                             ),
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Flexible(
//                                                 flex: 6,
//                                                 child: headerText(
//                                                   textSize: screenHeight * 0.029,
//                                                   text: 'D e l e t e  A c c o u n t ',
//                                                   screenHeight: screenHeight,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: screenHeight * 0.005,
//                                               ),
//                                               Flexible(
//                                                 flex: 3,
//                                                 child: textFields(
//                                                   controller: passwordController,
//                                                   screenHeight: screenHeight,
//                                                   screenWidth: screenWidth,
//                                                   hintText: 'password',
//                                                 ),
//                                               ),
//                                               Flexible(
//                                                 flex: 3,
//                                                 child: belowText(
//                                                   text: 'Dont have an account?',
//                                                   screenHeight: screenHeight,
//                                                   onPressed: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(builder: (context) => Getmail())
//                                                     );
//                                                   },
//                                                   buttonText: 'Sign Up',
//                                                 ),
//                                               ),
//                                               Flexible(flex: 2, child: Container()),
//                                               Flexible(
//                                                 flex: 4,
//                                                 child: CustomTextButton(
//                                                   onPressed: () {
//                                                     final password = passwordController.text;
//
//
//                                                     BlocProvider.of<DeleteUserBloc>(context).add(DeleteUserButtonPressed(
//                                                       password: password,
//                                                     ));
//                                                   },
//                                                   horizontalPadding: 55,
//                                                   buttonText: 'Delete',
//                                                   screenHeight: screenHeight,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: screenHeight * 0.02,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         boy(
//                                           screenHeight: screenHeight,
//                                           screenWidth: screenWidth,
//                                         ),
//                                         girl(
//                                           screenHeight: screenHeight,
//                                           screenWidth: screenWidth,
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             } else {
//               return Center(child: Text('Token retrieval failed.'));
//             }
//           }
//         },
//       ),
//     );
//   }
//
// }



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userDelete/bloc/deleteUser_bloc.dart';
import 'package:weave_frontend/userDelete/bloc/deleteUser_event.dart';
import 'package:weave_frontend/userDelete/bloc/deleteUser_state.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userSignUp/ui/userSignUp.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_bloc.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class DeleteUser extends StatefulWidget {
  @override
  _DeleteUserState createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final TextEditingController passwordController = TextEditingController();

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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<String?>(
        future: _getToken,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final token = snapshot.data;
            if (token != null) {
              return BlocProvider(
                create: (context) => DeleteUserBloc('https://weave-backend-pyfu.onrender.com', token),
                child: BlocListener<DeleteUserBloc, DeleteUserState>(
                  listener: (context, state) {
                    if (state is DeleteUserSuccess) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Getmail()),
                      );
                    } else if (state is DeleteUserFailure) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  child: BlocBuilder<DeleteUserBloc, DeleteUserState>(
                    builder: (context, state) {
                      if (state is DeleteUserLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        child: Container(
                          height: screenHeight,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 10,
                                child: weaveText(
                                  screenHeight: screenHeight,
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Container(),
                              ),
                              Expanded(
                                flex: 25,
                                child: Container(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: screenWidth * 0.87,
                                        width: screenWidth * 0.87,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.8,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Flexible(
                                              flex: 6,
                                              child: headerText(
                                                textSize: screenHeight * 0.029,
                                                text: 'D e l e t e  A c c o u n t ',
                                                screenHeight: screenHeight,
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.005,
                                            ),
                                            Flexible(
                                              flex: 3,
                                              child: textFields(
                                                controller: passwordController,
                                                screenHeight: screenHeight,
                                                screenWidth: screenWidth,
                                                hintText: 'password',
                                              ),
                                            ),
                                            Flexible(
                                              flex: 3,
                                              child: belowText(
                                                text: 'Don\'t have an account?',
                                                screenHeight: screenHeight,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Getmail()));
                                                },
                                                buttonText: 'Sign Up',
                                              ),
                                            ),
                                            Flexible(flex: 2, child: Container()),
                                            Flexible(
                                              flex: 4,
                                              child: CustomTextButton(
                                                onPressed: () {
                                                  final password =
                                                      passwordController.text;
                                                  BlocProvider.of<DeleteUserBloc>(
                                                      context)
                                                      .add(DeleteUserButtonPressed(
                                                    password: password,
                                                  ));
                                                },
                                                horizontalPadding: 55,
                                                buttonText: 'Delete',
                                                screenHeight: screenHeight,
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.02,
                                            ),
                                          ],
                                        ),
                                      ),
                                      boy(
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                      ),
                                      girl(
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(child: Text('Failed to load token.'));
            }
          }
        },
      ),
    );
  }
}
















// SingleChildScrollView(
// child: Container(
// height: screenHeight,
// child: Column(
// children: [
// Expanded(
// flex: 10,
// child: weaveText(
// screenHeight: screenHeight,
// ),
// ),
// Expanded(
// flex: 0,
// child: Container(),
// ),
// Expanded(
// flex: 25,
// child: Container(
// child: Stack(
// clipBehavior: Clip.none,
// children: [
// Container(
// height: screenWidth * 0.87,
// width: screenWidth * 0.87,
// decoration: BoxDecoration(
// color: Colors.transparent,
// borderRadius:
// BorderRadius.all(Radius.circular(35)),
// border: Border.all(
// color: Colors.black,
// width: 0.8,
// ),
// ),
// child: Column(
// children: [
// Flexible(
// flex: 6,
// child: headerText(
// textSize: screenHeight * 0.029,
// text: 'D e l e t e  A c c o u n t ',
// screenHeight: screenHeight,
// ),
// ),
// SizedBox(
// height: screenHeight * 0.005,
// ),
// Flexible(
// flex: 3,
// child: textFields(
// controller: passwordController,
// screenHeight: screenHeight,
// screenWidth: screenWidth,
// hintText: 'password',
// ),
// ),
// Flexible(
// flex: 3,
// child: belowText(
// text: 'Dont have an account?',
// screenHeight: screenHeight,
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => Getmail())
// );
// },
// buttonText: 'Sign Up',
// ),
// ),
// Flexible(flex: 2, child: Container()),
// Flexible(
// flex: 4,
// child: CustomTextButton(
// onPressed: () {
// final password = passwordController.text;
//
//
// BlocProvider.of<DeleteUserBloc>(context).add(DeleteUserButtonPressed(
// password: password,
// ));
// },
// horizontalPadding: 55,
// buttonText: 'Delete',
// screenHeight: screenHeight,
// ),
// ),
// SizedBox(
// height: screenHeight * 0.02,
// ),
// ],
// ),
// ),
// boy(
// screenHeight: screenHeight,
// screenWidth: screenWidth,
// ),
// girl(
// screenHeight: screenHeight,
// screenWidth: screenWidth,
// ),
// ],
// ),
// )
// )
// ],
// ),
// ),
// )