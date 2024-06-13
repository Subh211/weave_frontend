import 'package:flutter/material.dart';
import 'package:weave_frontend/changePassword/ui/changePassword.dart';
import 'package:weave_frontend/userDelete/ui/deleteUser.dart';
import 'package:weave_frontend/userLogOut/ui/userSignOut.dart';
import 'package:weave_frontend/userUpdate/ui/updateUser.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class  OptionScreen extends StatelessWidget {


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
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Color of the bottom border
                        width: 1.0, // Width of the bottom border
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignOut()));
                },
                child: optionText(
                  text: "Log Out",
                  screenHeight: screenHeight,
                )),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Color of the bottom border
                        width: 1.0, // Width of the bottom border
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteUser()));
                },
                child: optionText(
                  text: "Delete Account",
                  screenHeight: screenHeight,
                )),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Color of the bottom border
                        width: 1.0, // Width of the bottom border
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                      },
                      child: optionText(
                        text: "Change Password",
                        screenHeight: screenHeight,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Color of the bottom border
                        width: 1.0, // Width of the bottom border
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser()));
                      },
                      child: optionText(
                        text: "Update Account",
                        screenHeight: screenHeight,
                      )),
                ),
              ],
            ),
    ),
    );
  }
}
