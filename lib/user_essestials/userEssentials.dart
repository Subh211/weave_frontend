import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image/image.dart' as img;


class weaveText extends StatelessWidget {
  final double screenHeight;

  weaveText({required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        'Weave',
        style: GoogleFonts.clickerScript(
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(165, 179, 158, 1),
          fontSize: screenHeight * 0.1,
        ),
      ),
    );
  }
}

class headerText extends StatelessWidget {
  final double screenHeight;
  final String text;
  final double? textSize;

  headerText({
    required this.screenHeight,
    required this.text,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w200,
          fontSize: textSize ?? screenHeight * 0.034,
        ),
      ),
    );
  }
}

class textFields extends StatelessWidget {
  final bool? star;
  final double screenHeight;
  final double screenWidth;
  final String hintText;
  final TextEditingController? controller;

  const textFields({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.hintText,
    this.controller,
    this.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.47,
      child: TextField(
        controller: controller,
        maxLines: 1, // Limit to one line
        obscureText: star ?? false,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.8),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.grey[850],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis, // Handle overflow
          ),
        ),
      ),
    );
  }
}

class belowText extends StatelessWidget {
  final String? text;
  final String? buttonText;
  final VoidCallback? onPressed;
  final double screenHeight;

  belowText(
      {this.text, this.buttonText, this.onPressed, required this.screenHeight});

  @override
  build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (text != null)
          Text(
            text!,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: screenHeight * 0.012),
            ),
          ),
        if (onPressed != null && buttonText != null)
          TextButton(
            onPressed: onPressed!,
            child: Text(
              buttonText!,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: screenHeight * 0.015),
              ),
            ),
          ),
      ],
    );
  }
}

class boy extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final double? left;
  final double? top;

  boy({
    required this.screenHeight,
    required this.screenWidth,
    this.left,
    this.top
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left ??  -14,
        top: top ?? 140,
        child: Container(
          height: screenHeight * 0.35,
          width: screenWidth * 0.14,
          child: Image.asset('assests/images/boy.png'),
        ));
  }
}

class girl extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final double? right;
  final double? top;

  girl({
    required this.screenHeight,
    required this.screenWidth,
    this.right,
    this.top
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: right ?? -25,
        top: top ?? 140,
        child: Container(
          height: screenHeight * 0.38,
          width: screenWidth * 0.33,
          child: Image.asset('assests/images/girl.png'),
        ));
  }
}

class googleSignIn extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  googleSignIn({required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.12,
      width: screenWidth * 0.78,
      child: Image.asset('assests/images/google.png'),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double horizontalPadding;
  final String buttonText;
  final double screenHeight;
  final double? fontSize;
  final double? buttonHeight;
  final bool showPencilIcon; // Control the visibility of the pencil icon
  final bool showBorder; // Control the visibility of the border

  CustomTextButton({
    required this.onPressed,
    required this.horizontalPadding,
    required this.buttonText,
    required this.screenHeight,
    this.fontSize,
    this.buttonHeight,
    this.showPencilIcon = false, // Default to not showing the pencil icon
    this.showBorder = true, // Default to showing the border
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? screenHeight * 0.048,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFFC3B0E7), // Background color (light purple)
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            side: showBorder
                ? BorderSide(
                    color: Colors.black,
                    width: 1) // Border if showBorder is true
                : BorderSide(
                    color: Colors.transparent,
                    width: 1), // No border if showBorder is false
          ),
          shadowColor: Colors.black, // Shadow color
          elevation: 10, // Elevation
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showPencilIcon) // Conditionally render the pencil icon
              Icon(Icons.edit, color: Colors.white),
            if (showPencilIcon)
              SizedBox(width: 8), // Add some space if the pencil icon is shown
            Text(
              buttonText,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? screenHeight * 0.018,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class optionText extends StatelessWidget {
  final double screenHeight;
  final String text;

  optionText({
    required this.screenHeight,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
                textStyle: TextStyle(
                fontSize: screenHeight*0.025,
                color: Color.fromRGBO(165, 179, 158, 1),
                fontWeight: FontWeight.w600,
        ),
      ),
      )
    );

  }
}

// class ToggleHeartButton extends StatefulWidget {
//   @override
//   _ToggleHeartButtonState createState() => _ToggleHeartButtonState();
// }
//
// class _ToggleHeartButtonState extends State<ToggleHeartButton> {
//   bool isHeartPressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         setState(() {
//           isHeartPressed = !isHeartPressed;
//         });
//       },
//       icon: FaIcon(
//         isHeartPressed ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
//         color: isHeartPressed ? Colors.red : Colors.black,
//       ),
//     );
//   }
// }








class ToggleHeartButton extends StatefulWidget {
  final String friendId;
  final String postId;

  ToggleHeartButton({
    required this.friendId,
    required this.postId,
  });

  @override
  _ToggleHeartButtonState createState() => _ToggleHeartButtonState();
}

class _ToggleHeartButtonState extends State<ToggleHeartButton> {
  bool isHeartPressed = false;
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Replace with your server URL
  final String baseUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/post';

  Future<String?> _getStoredToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> sendLikeStatus(bool isLiked, String token) async {
    final String url = '$baseUrl/like/${widget.friendId}';
    final String query = '?postId=${widget.postId}';

    try {
      Response response;
      if (isLiked) {
        response = await dio.post(
          '$url$query',
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          ),
        );
      } else {
        response = await dio.delete(
          '$url$query',
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          ),
        );
      }

      if (response.statusCode == 200) {
        // Handle success
        print('Successfully sent like/unlike status');
      } else {
        // Handle server error
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getStoredToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('Token is missing or there was an error'));
        } else {
          final token = snapshot.data!;
          return IconButton(
            onPressed: () async {
              setState(() {
                isHeartPressed = !isHeartPressed;
              });

              await sendLikeStatus(isHeartPressed, token);
            },
            icon: FaIcon(
              isHeartPressed ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: isHeartPressed ? Colors.red : Colors.black,
            ),
          );
        }
      },
    );
  }
}

