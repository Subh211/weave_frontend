import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/likes/likeScreen/singleLikeScreen/ui/singleLike.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Likes',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: screenHeight * 0.04),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 50, // Number of comments
        itemBuilder: (context, index) {
          return Eachlike(); // Custom EachComment widget
        },
      ),
    );
  }
}
