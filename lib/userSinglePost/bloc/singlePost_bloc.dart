// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
// import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
// import 'post_repository.dart';
//
// class PostBloc extends Bloc<PostEvent, PostState> {
//   final PostRepository postRepository;
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//
//   PostBloc(this.postRepository) : super(PostInitial()) {
//     on<FetchPosts>(_onFetchPosts);
//   }
//
//   Future<String?> _getStoredToken() async {
//     final storedToken = await secureStorage.read(key: 'token');
//     print('Stored Token: $storedToken'); // For debugging
//     return storedToken;
//   }
//
//   Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
//     emit(PostLoading());
//     final storedToken = await _getStoredToken();
//     if (storedToken == null) {
//       emit(PostAuthenticationError('User is not signed in.'));
//       return;
//     }
//     try {
//       final posts = await postRepository.fetchPosts(storedToken);
//       emit(PostLoaded(posts));
//     } catch (e) {
//       emit(PostError(e.toString()));
//     }
//   }
// }











import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_event.dart';
import 'package:weave_frontend/userSinglePost/bloc/singlePost_state.dart';
import '../../models/postModel.dart';
import 'post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // For debugging
    return storedToken;
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(PostAuthenticationError('User is not signed in.'));
      return;
    }
    try {
      final result = await postRepository.fetchPosts(storedToken);
      final posts = result['posts'] as List<Post>;
      final username = result['username'] as String;
      emit(PostLoaded(posts, username));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
