import 'package:flutter_bloc/flutter_bloc.dart';
import 'like_event.dart';
import 'like_state.dart';
import 'package:weave_frontend/likes/likeScreen/likeScreen/bloc/like_repository.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeRepository likeRepository;

  LikeBloc(this.likeRepository) : super(LikeInitial()) {
    on<FetchLikes>((event, emit) async {
      emit(LikeLoading());
      try {
        final likes = await likeRepository.fetchLikes(event.postId, event.friendId);
        emit(LikeLoaded(likes));
      } catch (e) {
        emit(LikeError(e.toString()));
      }
    });
  }
}
