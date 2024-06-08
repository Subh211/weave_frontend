import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userSignUp/bloc/registration_event.dart';
import 'package:weave_frontend/userSinglePost/ui/singlePost.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';
import 'package:weave_frontend/userSignUp/bloc/registration_state.dart';
import 'package:weave_frontend/userSignUp/bloc/registration_bloc.dart';
// Import the Feed screen file

class Getmail extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController photoURLController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (context) => RegistrationBloc('http://localhost:3000'),
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccess) {
              // Show success message
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              // Navigate to the Feed screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Feed()), // Replace Feed() with your actual Feed screen
              );
            } else if (state is RegistrationFailure) {
              // Show failure message
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            builder: (context, state) {
              if (state is RegistrationLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Container(
                  height:
                      screenHeight, // Ensures the container takes the full height of the screen
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
                        flex: 36,
                        child: Container(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: screenHeight * 0.7,
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
                                      flex: 8,
                                      child: headerText(
                                        text: 'S i g n  U p',
                                        screenHeight: screenHeight,
                                      ),
                                    ),
                                    Flexible(flex: 1, child: Container()),
                                    Flexible(
                                      flex: 3,
                                      child: textFields(
                                        controller: nameController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Full Name',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: textFields(
                                        controller: emailController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Enter Email',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: textFields(
                                        star: true,
                                        controller: passwordController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Password',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: textFields(
                                        star: true,
                                        controller: confirmPasswordController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Confirm Password',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: textFields(
                                        controller: displayNameController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Username',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: textFields(
                                        controller: bioController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Bio',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Flexible(
                                        flex: 4,
                                        child: ImagePickerButton(
                                          controller: photoURLController,
                                          screenHeight: screenHeight,
                                        )),
                                    SizedBox(
                                      height: screenHeight * 0.012,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: belowText(
                                        text: 'Already have account?',
                                        screenHeight: screenHeight,
                                        onPressed: () {},
                                        buttonText: 'Sign In',
                                      ),
                                    ),
                                    Flexible(flex: 1, child: Container()),
                                    Flexible(
                                      flex: 4,
                                      child: CustomTextButton(
                                        onPressed: () {
                                          final email = emailController.text;
                                          final name = nameController.text;
                                          final password =
                                              passwordController.text;
                                          final confirmPassword =
                                              confirmPasswordController.text;
                                          final displayName =
                                              displayNameController.text;
                                          final bio = bioController.text;
                                          final photoURL =
                                              photoURLController.text;

                                          BlocProvider.of<RegistrationBloc>(
                                                  context)
                                              .add(RegisterUser(
                                            email: email,
                                            name: name,
                                            password: password,
                                            confirmPassword: confirmPassword,
                                            displayName: displayName,
                                            bio: bio,
                                            photoURL: photoURL,
                                          ));
                                        },
                                        horizontalPadding: 55,
                                        buttonText: 'Create',
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
                                  screenWidth: screenWidth),
                              girl(
                                  screenHeight: screenHeight,
                                  screenWidth: screenWidth),
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
      ),
    );
  }
}
