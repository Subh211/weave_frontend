import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_bloc.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_event.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_repository.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/ui/singleLike.dart';
import 'package:weave_frontend/models/postModel.dart';
import 'package:weave_frontend/userSinglePost/bloc/post_repository.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_bloc.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';

class Posts extends StatelessWidget {
  final PostRepository postRepository = PostRepository();
  final LikeRepository likeRepository = LikeRepository(); // Create an instance of LikeRepository

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(postRepository)..add(FetchPosts()),
      child: PostsView(likeRepository: likeRepository),
    );
  }
}

class PostsView extends StatelessWidget {
  final LikeRepository likeRepository;

  const PostsView({required this.likeRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostItem(post: post, likeRepository: likeRepository);
              },
            );
          } else if (state is PostError) {
            return Center(child: Text('Failed to load posts: ${state.message}'));
          } else if (state is PostAuthenticationError) {
            return Center(child: Text('Authentication error: ${state.message}'));
          }
          return Center(child: Text('No posts'));
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  final LikeRepository likeRepository;

  const PostItem({required this.post, required this.likeRepository});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: screenWidth * 0.025),
            Container(
              height: screenHeight * 0.065,
              width: screenWidth * 0.09,
              child: CircleAvatar(
                backgroundImage: post.profileImage != null
                    ? NetworkImage(post.profileImage!)
                    : AssetImage('assests/images/placeholder.png') as ImageProvider,
                onBackgroundImageError: (_, __) {
                  print("Error loading profile image");
                },
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Text(
              post.username ?? 'Unknown User',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.58,
          width: screenWidth,
          child: post.postImage != null
              ? Image.network(
            post.postImage!,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image.asset('assests/images/placeholder.png'); // Path to your placeholder image
            },
          )
              : Image.asset('assests/images/placeholder.png'), // Path to your placeholder image
        ),
        Container(
          height: screenHeight * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth * 0.01),
              ToggleHeartButton(postId: post.postId!, friendId: post.friendId!),
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.comments),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.04),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => LikeBloc(likeRepository)..add(FetchLikes(post.postId!, post.friendId!)),
                      child: EachlikeScreen(),
                    ),
                  ),
                );
              },
              child: Text(
                'Liked by ${post.likes} others',
                style: GoogleFonts.lora(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.04),
            Text(
              post.username ?? 'Unknown User',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Flexible(
              child: Text(
                post.caption ?? '',
                style: GoogleFonts.lora(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.04),
            Text(
              'All comments',
              style: GoogleFonts.lora(
                textStyle: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
