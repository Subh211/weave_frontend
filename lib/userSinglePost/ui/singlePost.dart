import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_bloc.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_event.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_repository.dart';
import 'package:weave_frontend/comments/commentScreen/ui/commentScreen.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_bloc.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_event.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_repository.dart';
import 'package:weave_frontend/friendProfile/ui/friendProfile.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_bloc.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_event.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_repository.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/ui/singleLike.dart';
import 'package:weave_frontend/models/postModel.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_bloc.dart';
import 'package:weave_frontend/userProfile/ui/profile.dart';
import 'package:weave_frontend/userSinglePost/bloc/post_repository.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_bloc.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
import 'package:weave_frontend/user_essestials/userEssentials.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';


import '../../comments/singleComment/ui/singleComment.dart';

class Posts extends StatelessWidget {
  final PostRepository postRepository = PostRepository();
  final LikeRepository likeRepository = LikeRepository();// Create an instance of LikeRepository
  final CommentScreenRepository commentScreenRepository = CommentScreenRepository();
  final GetFriendProfileRepository getFriendProfileRepository = GetFriendProfileRepository();
  final GetUserProfileRepository getUserProfileRepository = GetUserProfileRepository();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(postRepository)..add(FetchPosts()),
      child: PostsView(likeRepository: likeRepository,
          commentScreenRepository: commentScreenRepository,
          getFriendProfileRepository: getFriendProfileRepository,
          getUserProfileRepository: getUserProfileRepository,
      ),
    );
  }
}

class PostsView extends StatelessWidget {
  final LikeRepository likeRepository;
  final CommentScreenRepository commentScreenRepository;
  final GetFriendProfileRepository getFriendProfileRepository;
  final GetUserProfileRepository getUserProfileRepository;


  const PostsView({
    required this.likeRepository,
    required this.commentScreenRepository,
    required this.getFriendProfileRepository,
    required this.getUserProfileRepository,
  });

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
                final usersName = state.username;
                final post = state.posts[index];
                return PostItem(
                    username: usersName,
                    post: post,
                    likeRepository: likeRepository,
                    commentScreenRepository: commentScreenRepository,
                    getFriendProfileRepository: getFriendProfileRepository,
                    getUserProfileRepository: getUserProfileRepository,
                );
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
  final CommentScreenRepository commentScreenRepository;
  final GetFriendProfileRepository getFriendProfileRepository;
  final String username;
  final GetUserProfileRepository getUserProfileRepository;

  final ValueNotifier<int> likesNotifier;

  PostItem({
    required this.post,
    required this.likeRepository,
    required this.commentScreenRepository,
    required this.getFriendProfileRepository,
    required this.username,
    required this.getUserProfileRepository,
  }) : likesNotifier = ValueNotifier(post.likes ?? 0);

  Future<String?> _retrieveToken() async {
    return await FlutterSecureStorage().read(key: 'token');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InkWell(
          onTap: () async {
            final token = await _retrieveToken();
            if (post.username! == username) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => GetUserProfileBloc(getUserProfileRepository, token!),
                    child: OwnProfile(),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => GetFriendProfileBloc(getFriendProfileRepository)
                      ..add(FetchFriendProfileEvent(friendId: post.friendId!)),
                    child: FriendProfile(friendId: post.friendId!),
                  ),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth * 0.025),
              Container(
                height: screenHeight * 0.065,
                width: screenWidth * 0.09,
                child: CircleAvatar(
                  backgroundImage: post.profileImage != null
                      ? NetworkImage(post.profileImage!)
                      : AssetImage('assets/images/placeholder.png') as ImageProvider,
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
        ),
        Container(
          height: screenHeight * 0.58,
          width: screenWidth,
          child: post.postImage != null
              ? Image.network(
            post.postImage!,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image.asset('assets/images/placeholder.png');
            },
          )
              : Image.asset('assets/images/placeholder.png'),
        ),
        Container(
          height: screenHeight * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth * 0.01),
              ToggleHeartButton(
                postId: post.postId!,
                friendId: post.friendId!,
                onLikeStatusChanged: (isLiked) {
                  if (isLiked) {
                    likesNotifier.value += 1;
                  } else {
                    likesNotifier.value -= 1;
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoComment(
                        postId: post.postId!,
                        friendId: post.friendId!,
                      ),
                    ),
                  );
                },
                icon: FaIcon(FontAwesomeIcons.comments),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: likesNotifier,
          builder: (context, likesCount, child) {
            return Row(
              children: [
                SizedBox(width: screenWidth * 0.04),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => LikeBloc(likeRepository)
                            ..add(FetchLikes(post.postId!, post.friendId!)),
                          child: EachlikeScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Liked by $likesCount others',
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
            );
          },
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
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => CommentScreenBloc(commentScreenRepository)
                        ..add(FetchComments(post.postId!, post.friendId!)),
                      child: CommentScreen(),
                    ),
                  ),
                );
              },
              child: Text(
                'All comments',
                style: GoogleFonts.lora(
                  textStyle: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

