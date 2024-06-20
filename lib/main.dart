import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/comments/commentScreen/ui/commentScreen.dart';
import 'package:weave_frontend/comments/singleComment/ui/singleComment.dart';
import 'package:weave_frontend/optionScreen/ui/optionScreen.dart';
import 'package:weave_frontend/splashScreen/splashScreen.dart';
import 'package:weave_frontend/userAddPost/ui/addPost.dart';
import 'package:weave_frontend/userFeed/ui/feed.dart';
import 'package:weave_frontend/userLogIn/ui/userLogIn.dart';
import 'package:weave_frontend/userLogOut/ui/userSignOut.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';

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
        home: SplashScreen());
  }
}




//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';
// import 'package:weave_frontend/splashScreen/splashScreen.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//       future: FlutterSecureStorage().read(key: 'token'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           final token = snapshot.data ?? '';
//           return BlocProvider(
//             create: (context) => GetUserProfileBloc(getUserProfileRepository, token),
//             child: MaterialApp(
//               title: 'Weave',
//               theme: ThemeData(
//                 primarySwatch: Colors.blue,
//               ),
//               home: SplashScreen(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
