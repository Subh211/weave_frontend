// // like_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_event.dart';
// import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_repository.dart';
// import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_state.dart';
// import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_repository.dart'; // Assume you have a repository
//
// class CommentScreenBloc extends Bloc<CommentScreenEvent, CommentScreenState> {
//   final CommentScreenRepository commentScreenRepository;
//
//   CommentScreenBloc(this.commentScreenRepository) : super(CommentScreenInitial()) {
//     on<FetchComments>((event, emit) async {
//       emit(CommentScreenLoading());
//       try {
//         final comments = await commentScreenRepository.fetchComments(event.postId, event.friendId);
//         emit(CommentScreenLoaded(comments));
//       } catch (e) {
//         emit(CommentScreenError(e.toString()));
//       }
//     });
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_event.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_repository.dart';
import 'package:weave_frontend/comments/commentScreen/bloc/commentScreen_state.dart';

class CommentScreenBloc extends Bloc<CommentScreenEvent, CommentScreenState> {
  final CommentScreenRepository commentScreenRepository;

  CommentScreenBloc(this.commentScreenRepository) : super(CommentScreenInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentScreenLoading());
      try {
        final comments = await commentScreenRepository.fetchComments(event.postId, event.friendId);
        emit(CommentScreenLoaded(comments));
      } catch (e) {
        emit(CommentScreenError(e.toString()));
      }
    });
  }
}
