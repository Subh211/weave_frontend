import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_bloc.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_state.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_state.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
       double screenHeight = MediaQuery.of(context).size.height;
       double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<CommentScreenBloc, CommentScreenState>(
        builder: (context, state) {
          if (state is LikeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentScreenLoaded) {
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final comment = state.comments[index];
                 return SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.075,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 29.0, // Adjust this value to change the size
                            backgroundImage: NetworkImage(comment.userImage),
                          ),

                          SizedBox(width: 8.0), // Adding some space between avatar and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.userName,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: screenHeight*0.018,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  comment.comment,
                                  style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                      fontSize: screenHeight*0.015,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  maxLines: null, // Allows text to wrap into multiple lines
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
            );
          } else if (state is CommentScreenError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No comments available'));
        },
      ),
    );
  }
}
