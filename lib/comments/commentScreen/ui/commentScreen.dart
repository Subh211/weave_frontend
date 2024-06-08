import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/comments/singleComment/ui/singleComment.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: screenHeight * 0.03),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 50, // Number of comments
        itemBuilder: (context, index) {
          return Eachcomment(); // Custom EachComment widget
        },
      ),
    );
  }
}
