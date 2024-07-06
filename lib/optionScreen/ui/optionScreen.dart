import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/changePassword/ui/changePassword.dart';
import 'package:weave_frontend/userDelete/bloc/deleteUser_bloc.dart';
import 'package:weave_frontend/userDelete/ui/deleteUser.dart';
import 'package:weave_frontend/userLogOut/ui/userSignOut.dart';
import 'package:weave_frontend/userUpdate/ui/updateUser.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class OptionScreen extends StatefulWidget {
  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  late Future<String?> _getToken;

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<String?>(
        future: _getToken,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: ProcessIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Token retrieval failed.'));
          } else {
            final token = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  optionItem(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    text: "Log Out",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignOut()));
                    },
                  ),
                  optionItem(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    text: "Update Account",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser()));
                    },
                  ),
                  optionItem(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    text: "Change Password",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                    },
                  ),
                  BlocProvider(
                    create: (context) => DeleteUserBloc('https://weave-backend-pyfu.onrender.com', token),
                    child: optionItem(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      text: "Delete Account",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteUser()));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget optionItem({required double screenHeight, required double screenWidth, required String text, required VoidCallback onTap}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: optionText(
                text:text,
                screenHeight: screenHeight,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: screenWidth * 0.2,
          right: screenWidth * 0.2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(165, 179, 158, 1).withOpacity(0.8),
                  offset: Offset(0, 2),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}