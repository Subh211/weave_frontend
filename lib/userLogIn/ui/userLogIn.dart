import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userLogIn/bloc/signIn_bloc.dart';
import 'package:weave_frontend/userLogIn/bloc/signIn_event.dart';
import 'package:weave_frontend/userLogIn/bloc/signIn_state.dart';
import 'package:weave_frontend/userSignUp/ui/userSignUp.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
       create:  (context) => SignInBloc('https://weave-backend-pyfu.onrender.com'),
        child: BlocListener<SignInBloc,SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Feed()),
              );
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<SignInBloc,SignInState> (
            builder: (context,state) {
              if (state is SignInLoading) {
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
                                            text: 'L o g  I n',
                                            screenHeight: screenHeight,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.005,
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: textFields(
                                            controller: emailController,
                                            screenHeight: screenHeight,
                                            screenWidth: screenWidth,
                                            hintText: 'Enter email',
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.005,
                                        ),
                                        Flexible(
                                          flex: 3,
                                          child: textFields(
                                            controller: passwordController,
                                            star: true,
                                            screenHeight: screenHeight,
                                            screenWidth: screenWidth,
                                            hintText: 'Password',
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
                                              final email = emailController.text;
                                              final password = passwordController.text;

                                              BlocProvider.of<SignInBloc>(context).add(SignInButtonPressed(
                                                email: email,
                                                password: password,
                                              ));
                                            },
                                            horizontalPadding: 55,
                                            buttonText: 'Log In',
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
      )
    );
  }
}

