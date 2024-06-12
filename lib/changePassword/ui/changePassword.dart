import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/changePassword/bloc/changePassword_bloc.dart';
import 'package:weave_frontend/changePassword/bloc/changePassword_event.dart';
import 'package:weave_frontend/changePassword/bloc/changePassword_state.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userLogIn/bloc/signIn_bloc.dart';
import 'package:weave_frontend/userSignUp/ui/userSignUp.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}



class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

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
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              final token = snapshot.data;

              if (token != null) {
                return BlocProvider(
                  create:  (context) => ChangePasswordBloc('https://weave-backend-pyfu.onrender.com',token),
                  child: BlocListener<ChangePasswordBloc,ChangePasswordState>(
                    listener: (context, state) {
                      if (state is ChangePasswordSuccess) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.message)));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Feed()),
                        );
                      } else if (state is ChangePasswordFailure) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    child: BlocBuilder<ChangePasswordBloc,ChangePasswordState> (
                      builder: (context,state) {
                        if (state is ChangePasswordLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return
                          SingleChildScrollView(
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
                                                      text: 'C h a n g e  P a s s w o r d',
                                                      screenHeight: screenHeight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.005,
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: textFields(
                                                      controller: oldPasswordController,
                                                      screenHeight: screenHeight,
                                                      screenWidth: screenWidth,
                                                      hintText: 'old password',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.005,
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: textFields(
                                                      controller: newPasswordController,
                                                      star: true,
                                                      screenHeight: screenHeight,
                                                      screenWidth: screenWidth,
                                                      hintText: 'new password',
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    child: belowText(
                                                      text: 'Dont have an account?',
                                                      screenHeight: screenHeight,
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => Getmail())
                                                        );
                                                      },
                                                      buttonText: 'Sign Up',
                                                    ),
                                                  ),
                                                  Flexible(flex: 2, child: Container()),
                                                  Flexible(
                                                    flex: 4,
                                                    child: CustomTextButton(
                                                      onPressed: () {
                                                        print('token $token' );
                                                        final oldPassword = oldPasswordController.text;
                                                        final newPassword = newPasswordController.text;

                                                        BlocProvider.of<ChangePasswordBloc>(context).add(ChangePasswordButtonPressed(
                                                          oldPassword: oldPassword,
                                                          newPassword: newPassword,
                                                        ));
                                                      },
                                                      horizontalPadding: 55,
                                                      buttonText: 'Change',
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
                                      )
                                  )
                                ],
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                );
              }
              else {
                return Center(
                  child: Text('Token retrieval failed.'),
                );
              }
            };
          }
        )

    );
  }
}

