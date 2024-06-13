import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_bloc.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_event.dart';
import 'package:weave_frontend/userUpdate/bloc/userUpdate_state.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}



class _UpdateUserState extends State<UpdateUser> {
  final TextEditingController displayNameController = TextEditingController();
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
                    create:  (context) => UpdateUserBloc('https://weave-backend-pyfu.onrender.com',token),
                    child: BlocListener<UpdateUserBloc,UpdateUserState>(
                      listener: (context, state) {
                        if (state is UpdateUserSuccess) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(state.message)));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Feed()),
                          );
                        } else if (state is UpdateUserFailure) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      child: BlocBuilder<UpdateUserBloc,UpdateUserState> (
                        builder: (context,state) {
                          if (state is UpdateUserLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return
                            SingleChildScrollView(
                              child: Container(
                                height:
                                screenHeight, // Ensures the container takes the full height of the screen
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: weaveText(
                                        screenHeight: screenHeight,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 16,
                                      child: Container(
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              height: screenWidth * 0.87,
                                              width: screenWidth * 0.87,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(Radius.circular(35)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 0.8,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Flexible(
                                                    flex: 4,
                                                    child: headerText(
                                                      text: 'U p d a t e  A c c o u n t',
                                                      textSize: screenHeight * 0.028,
                                                      screenHeight: screenHeight,
                                                    ),
                                                  ),
                                                  Flexible(flex: 2, child: Container()),
                                                  Flexible(
                                                    flex: 2,
                                                    child: textFields(
                                                      controller: displayNameController,
                                                      screenHeight: screenHeight,
                                                      screenWidth: screenWidth,
                                                      hintText: 'username',
                                                    ),
                                                  ),
                                                  Flexible(flex: 2, child: Container()),
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
                                                  Flexible(flex: 1, child: Container()),
                                                  Flexible(
                                                    flex: 3,
                                                    child: CustomTextButton(
                                                      onPressed: () {
                                                        {
                                                          print('token $token' );
                                                          final displayName = displayNameController.text;


                                                          BlocProvider.of<UpdateUserBloc>(context).add(UpdateUserButtonPressed(
                                                            displayName: displayName,
                                                            photoURL: image, // Pass the File object
                                                          ));
                                                        };
                                                      },
                                                      horizontalPadding: 65,
                                                      buttonText: 'Update',
                                                      screenHeight: screenHeight,
                                                    ),
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
                                    Expanded(
                                      flex: 4,
                                      child: Container(),
                                    ),
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


