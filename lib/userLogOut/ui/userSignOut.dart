import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userLogIn/ui/userLogIn.dart';
import 'package:weave_frontend/userLogOut/bloc/signOut_bloc.dart';
import 'package:weave_frontend/userLogOut/bloc/signOut_event.dart';
import 'package:weave_frontend/userLogOut/bloc/signOut_state.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class SignOut extends StatefulWidget {


  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {

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
        body: FutureBuilder<String?> (
          future: _getToken,
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              final token = snapshot.data;
              if (token != null) {
                return BlocProvider(
                  create:  (context) => SignOutBloc('https://weave-backend-pyfu.onrender.com',token),
                  child: BlocListener<SignOutBloc,SignOutState>(
                    listener: (context, state) {
                      if (state is SignOutSuccess) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.message)));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      } else if (state is SignOutFailure) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    child: BlocBuilder<SignOutBloc,SignOutState> (
                      builder: (context,state) {
                        if (state is SignOutLoading) {
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
                                                      text: 'L o g  O u t',
                                                      screenHeight: screenHeight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.005,
                                                  ),

                                                  Flexible(flex: 2, child: Container()),
                                                  Flexible(
                                                    flex: 4,
                                                    child: CustomTextButton(
                                                      onPressed: () {
                                                        BlocProvider.of<SignOutBloc>(context).add(SignOutButtonPressed(

                                                        ));
                                                      },
                                                      horizontalPadding: 55,
                                                      buttonText: 'Log Out',
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
              } else {
                return Center(
                  child: Text('Token retrieval failed.'),
                );
              }
            }
          }
        )
    );
  }
}


