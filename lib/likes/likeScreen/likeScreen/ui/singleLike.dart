import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_bloc.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_state.dart';

class EachlikeScreen extends StatelessWidget {
  const EachlikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Likes', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<LikeBloc, LikeState>(
        builder: (context, state) {
          if (state is LikeLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LikeLoaded) {
            return ListView.builder(
              itemCount: state.likes.length,
              itemBuilder: (context, index) {
                final like = state.likes[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.06,
                    ),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(like.userProfileImage),
                        ),
                        SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(3, 11, 0, 0),
                          child: Text(
                            like.userName,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.height * 0.018,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LikeError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No likes available'));
        },
      ),
    );
  }
}
