import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userSignUp/ui/userSignUp.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  Future<void> _navigateBasedOnLoginStatus() async {
    // Wait for 3 seconds
    await Future.delayed(Duration(seconds: 3));

    // Check login status
    String? token = await secureStorage.read(key: 'token');
    if (token != null) {
      // Token is present, navigate to Feed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Feed()),
      );
    } else {
      // No token, navigate to Getmail (Sign Up)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Getmail()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            weaveText(screenHeight: screenHeight),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
