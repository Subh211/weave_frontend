import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class Updateuser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                                  screenHeight: screenHeight,
                                  screenWidth: screenWidth,
                                  hintText: 'username',
                                ),
                              ),
                              Flexible(flex: 2, child: Container()),
                              Flexible(
                                  flex: 4,
                                  child: textFields(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    hintText: 'bio',
                                  ),
                              ),
                              Flexible(flex: 1, child: Container()),
                              Flexible(
                                flex: 3,
                                child: CustomTextButton(
                                  onPressed: () {},
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
        ),
      ),
    );
  }
}
