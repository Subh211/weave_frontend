import 'package:flutter/material.dart';
import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
import 'package:weave_frontend/splashScreen/splashScreen.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userLogIn/ui/userLogIn.dart';
import 'package:weave_frontend/userLogOut/ui/userSignOut.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SignIn());
  }
}




