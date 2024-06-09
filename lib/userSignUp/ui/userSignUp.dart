import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userSignUp/bloc/registration_event.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';

class Getmail extends StatefulWidget {
  @override
  _GetmailState createState() => _GetmailState();
}

class _GetmailState extends State<Getmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  File? image;

  Future pickImage() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final photoURL = File(pickedFile.path);

      setState(() => this.image = photoURL);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (context) => RegistrationBloc('https://weave-backend-pyfu.onrender.com'),
        child: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Feed()),
              );
            } else if (state is RegistrationFailure) {
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
                                      flex: 7,
                                      child: headerText(
                                        text: 'S i g n  U p',
                                        screenHeight: screenHeight,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: textFields(
                                        controller: nameController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Full Name',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: textFields(
                                        controller: emailController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Enter Email',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: textFields(
                                        star: true,
                                        controller: passwordController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Password',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: textFields(
                                        star: true,
                                        controller: confirmPasswordController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Confirm Password',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: textFields(
                                        controller: displayNameController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Username',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: textFields(
                                        controller: bioController,
                                        screenHeight: screenHeight,
                                        screenWidth: screenWidth,
                                        hintText: 'Bio',
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Flexible(
                                      flex: 4,
                                      child: TextButton(
                                        onPressed: () => pickImage(),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: Colors.black, width: 2.5),
                                          ),
                                          shadowColor: Colors.black,
                                          elevation: 15,
                                        ),
                                        child: Text(
                                          'Pick an Image',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: screenHeight * 0.018,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          final password = passwordController.text;
                                          final confirmPassword = confirmPasswordController.text;
                                          final displayName = displayNameController.text;
                                          final bio = bioController.text;

                                          BlocProvider.of<RegistrationBloc>(context).add(RegisterUser(
                                            email: email,
                                            name: name,
                                            password: password,
                                            confirmPassword: confirmPassword,
                                            displayName: displayName,
                                            bio: bio,
                                            photoURL: image, // Pass the File object
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
