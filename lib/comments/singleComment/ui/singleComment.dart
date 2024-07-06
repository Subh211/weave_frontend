import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/comments/singleComment/bloc/comment_bloc.dart';
import 'package:weave_frontend/comments/singleComment/bloc/comment_event.dart';
import 'package:weave_frontend/comments/singleComment/bloc/comment_state.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';
import 'package:dio/dio.dart';

class DoComment extends StatefulWidget {
  final String postId;
  final String friendId;

  const DoComment({super.key, required this.postId, required this.friendId});

  @override
  State<DoComment> createState() => _DoCommentState();
}

class _DoCommentState extends State<DoComment> {
  late Future<String?> _getToken = _retrieveToken();

  @override
  void initState() {
    super.initState();
    _getToken = _retrieveToken();
  }

  Future<String?> _retrieveToken() async {
    return await FlutterSecureStorage().read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocProvider(
        create: (context) => CommentBloc(Dio(), ''), // Provide a Dio instance and an empty token for now
        child: BlocListener<CommentBloc, CommentState>(
          listener: (context, state) {
            if (state is CommentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Comment posted successfully")));
            } else if (state is CommentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentInProgress) {
                return Center(child: ProcessIndicator());
              }
              return Scaffold(
                body: FutureBuilder<String?> (
                    future: _getToken,
                    builder: (context,snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: ProcessIndicator());
                      } else {
                        final token = snapshot.data;
                        if (token != null) {
                          return BlocProvider(
                            create: (context) => CommentBloc(Dio(), token),
                            child: BlocListener<CommentBloc, CommentState>(
                              listener: (context, state) {
                                if (state is CommentSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Comment posted successfully")));
                                } else if (state is CommentFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                                }
                              },
                              child: BlocBuilder<CommentBloc, CommentState>(
                                builder: (context, state) {
                                  if (state is CommentInProgress) {
                                    return Center(child: ProcessIndicator());
                                  }
                                  return SingleChildScrollView(
                                    child: Container(
                                      height: screenHeight,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: weaveText(
                                              screenHeight: screenHeight,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 0,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 25,
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
                                                          flex: 6,
                                                          child: headerText(
                                                            text: 'C  O  M  M  E  N  T',
                                                            screenHeight: screenHeight,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: screenHeight * 0.005,
                                                        ),
                                                        Flexible(
                                                          flex: 3,
                                                          child: textFields(
                                                            controller: commentController,
                                                            screenHeight: screenHeight,
                                                            screenWidth: screenWidth,
                                                            hintText: 'comment',
                                                          ),
                                                        ),
                                                        Flexible(flex: 2, child: Container()),
                                                        Flexible(
                                                          flex: 4,
                                                          child: CustomTextButton(
                                                            onPressed: () {
                                                              final comment = commentController.text;
                                    
                                                              if (comment.isNotEmpty) {
                                                                BlocProvider.of<CommentBloc>(context).add(DoCommentEvent(
                                                                  comment: comment,
                                                                  postId: widget.postId,
                                                                  friendId: widget.friendId,
                                                                ));
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                  content: Text("Comments can not be empty"),
                                                                ));
                                                              }
                                                            },
                                                            horizontalPadding: 55,
                                                            buttonText: 'Comment',
                                                            screenHeight: screenHeight,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: screenHeight * 0.02,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  boy(
                                                    screenHeight: screenHeight,
                                                    screenWidth: screenWidth,
                                                  ),
                                                  girl(
                                                    screenHeight: screenHeight,
                                                    screenWidth: screenWidth,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );


                        } else {
                          return Center(
                            child: Text('Token retrieval failed.'),
                          );
                        }
                      }
                    }
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

