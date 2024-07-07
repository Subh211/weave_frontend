import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'dart:io';


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

class textFields extends StatefulWidget {
  final bool star;
  final double screenHeight;
  final double screenWidth;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const textFields({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.hintText,
    this.controller,
    this.star = false,
    this.validator,
  }) : super(key: key);

  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<textFields> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.star;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.47,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.8),
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
            ),
          ),
          suffixIcon: widget.star
              ? IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: _obscureText ? Colors.grey : Colors.grey[900],
            ),
            onPressed: _toggleObscureText,
          )
              : null,
        ),
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis, // Handle overflow
          ),
        ),
        validator: widget.validator,
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
  final Color? backgroundColor;
  final bool showPencilIcon; // Control the visibility of the pencil icon
  final bool showBorder; // Control the visibility of the border

  CustomTextButton({
    required this.onPressed,
    required this.horizontalPadding,
    required this.buttonText,
    required this.screenHeight,
    this.fontSize,
    this.buttonHeight,
    this.backgroundColor,
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
          backgroundColor: backgroundColor ?? Color(0xFFC3B0E7), // Background color (light purple)
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

class ToggleHeartButton extends StatefulWidget {
  final String friendId;
  final String postId;
  final ValueChanged<bool> onLikeStatusChanged; // Add this callback

  ToggleHeartButton({
    required this.friendId,
    required this.postId,
    required this.onLikeStatusChanged, // Initialize callback
  });

  @override
  _ToggleHeartButtonState createState() => _ToggleHeartButtonState();
}

class _ToggleHeartButtonState extends State<ToggleHeartButton> {
  bool isHeartPressed = false;
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
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
        // Notify the parent widget about the like status change
        widget.onLikeStatusChanged(isLiked);
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
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
              color: isHeartPressed ? Color(0xFFC3B0E7) : Colors.black,
            ),
          );
        }
      },
    );
  }
}

class ToggleHeartButtonForUserPosts extends StatefulWidget {
  final bool isLiked;
  final String friendId;
  final String postId;
  final ValueChanged<bool> onLikeStatusChanged; // Add this callback

  ToggleHeartButtonForUserPosts({
    required this.isLiked,
    required this.friendId,
    required this.postId,
    required this.onLikeStatusChanged, // Initialize callback
  });

  @override
  _ToggleHeartButtonForUserPosts createState() => _ToggleHeartButtonForUserPosts();
}

class _ToggleHeartButtonForUserPosts extends State<ToggleHeartButtonForUserPosts> {
  late bool isToggeled;
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final String baseUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/post';

  @override
  void initState() {
    super.initState();
    isToggeled = widget.isLiked;
  }

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
        // Notify the parent widget about the like status change
        widget.onLikeStatusChanged(isLiked);
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error: $e');
    }
  }

  void _toggleButton() async {
    final token = await _getStoredToken();
    if (token == null) {
      print('Token is missing');
      return;
    }

    setState(() {
      isToggeled = !isToggeled;
    });

    await sendLikeStatus(isToggeled, token); // Pass isToggled directly
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
            onPressed: _toggleButton,
            icon: FaIcon(
              isToggeled ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: isToggeled ? Color(0xFFC3B0E7) : Colors.black,
            ),
          );
        }
      },
    );
  }
}

class CustomTextButtonForFriend extends StatefulWidget {
  final VoidCallback onPressed;
  final double horizontalPadding;
  final double screenHeight;
  final double? fontSize;
  final double? buttonHeight;
  final Color? backgroundColor;
  final bool showPencilIcon; // Control the visibility of the pencil icon
  final bool showBorder; // Control the visibility of the border
  final bool isFriend; // Initialize this parameter
  final String friendId;
  final ValueChanged<bool> onFollowersStatusChanged; // Add this callback


  CustomTextButtonForFriend({
    required this.onPressed,
    required this.horizontalPadding,
    required this.screenHeight,
    this.fontSize,
    this.buttonHeight,
    this.backgroundColor,
    this.showPencilIcon = false, // Default to not showing the pencil icon
    this.showBorder = true, // Default to showing the border
    required this.isFriend, // Initialize this parameter
    required this.friendId,
    required this.onFollowersStatusChanged// Add friendId parameter
  });

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButtonForFriend> {
  late bool isToggled;
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Replace with your server URL
  final String baseUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/friend';

  @override
  void initState() {
    super.initState();
    isToggled = widget.isFriend;
  }

  Future<String?> _getStoredToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> sendFollowStatus(bool isFriend, String token) async {
    final String url = '$baseUrl/${widget.friendId}';
    try {
      Response response;
      if (isFriend) {
        response = await dio.delete(
          url,
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          ),
        );
      } else {
        response = await dio.post(
          url,
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          ),
        );
      }

      if (response.statusCode == 200) {
        widget.onFollowersStatusChanged(isFriend);
        print('Successfully sent follow/unfollow status');
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error: $e');
    }
  }

  void _toggleButton() async {
    final token = await _getStoredToken();
    if (token == null) {
      // Handle missing token
      print('Token is missing');
      return;
    }

    setState(() {
      isToggled = !isToggled;
    });

    // The isToggled variable is already toggled above, so pass the opposite to sendFollowStatus
    await sendFollowStatus(!isToggled, token);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.buttonHeight ?? widget.screenHeight * 0.048,
      child: TextButton(
        onPressed: _toggleButton,
        style: TextButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? Color(0xFFC3B0E7), // Background color (light purple)
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
            side: widget.showBorder
                ? BorderSide(
              color: Colors.black,
              width: 1, // Border if showBorder is true
            )
                : BorderSide(
              color: Colors.transparent,
              width: 1, // No border if showBorder is false
            ),
          ),
          shadowColor: Colors.black, // Shadow color
          elevation: 10, // Elevation
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.showPencilIcon) // Conditionally render the pencil icon
              Icon(Icons.edit, color: Colors.white),
            if (widget.showPencilIcon)
              SizedBox(width: 8), // Add some space if the pencil icon is shown
            Text(
              isToggled ? 'Unfollow' : 'Follow',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: widget.fontSize ?? widget.screenHeight * 0.018,
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

class profileText extends StatelessWidget {
  final String primaryText;
  final String secondaryText;

  profileText({
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: primaryText,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextSpan(
            text: secondaryText,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class ProcessIndicator extends StatelessWidget {

  const ProcessIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          color: Color(0xFFC3B0E7),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}




