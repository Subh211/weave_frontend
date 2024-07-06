import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weave_frontend/models/usersFeedModel.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_event.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_repository.dart';
import 'package:weave_frontend/usersFeed/bloc/usersFeed_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  final UserPostRepository userPostRepository;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  UserPostBloc(this.userPostRepository) : super(UserPostInitial()) {
    on<FetchUserPosts>(_onFetchUserPosts);
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    print('Stored Token: $storedToken'); // For debugging
    return storedToken;
  }

  Future<void> _onFetchUserPosts(FetchUserPosts event, Emitter<UserPostState> emit) async {
    emit(UserPostLoading());
    final storedToken = await _getStoredToken();
    if (storedToken == null) {
      emit(UserPostAuthenticationError('User is not signed in.'));
      return;
    }
    try {
      final List<usersPost> result = await userPostRepository.fetchUserPosts(storedToken);
      emit(UserPostLoaded(result));
    } catch (e) {
      emit(UserPostError(e.toString()));
    }
  }
}
