// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
// import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
// import 'userProfile_repository.dart';

// class GetUserProfileBloc extends Bloc<GetUserProfileEvent, GetUserProfileState> {
//   final GetUserProfileRepository getUserProfileRepository;
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   final String token;
//
//
//   GetUserProfileBloc(this.getUserProfileRepository,this.token) : super(UserProfileInitial()) {
//     on<FetchUserProfileEvent>(_onFetchUserProfile);
//   }
//
//   Future<String?> _getStoredToken() async {
//     final storedToken = await secureStorage.read(key: 'token');
//     print('Stored Token: $storedToken'); // For debugging
//     return storedToken;
//   }
//
//   Future<void> _onFetchUserProfile(FetchUserProfileEvent event, Emitter<GetUserProfileState> emit) async {
//     emit(UserProfileLoading());
//     final storedToken = await _getStoredToken();
//     if (storedToken == null) {
//       emit(UserProfileAuthenticationError('User is not signed in.'));
//       return;
//     }
//     try {
//       final posts = await getUserProfileRepository.fetchProfile(storedToken);
//       emit(UserProfileLoaded(posts));
//     } catch (e) {
//       emit(UserProfileError(e.toString()));
//     }
//   }
// }




import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_event.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_state.dart';
import 'package:weave_frontend/userProfile/bloc/userProfile_repository.dart';

class GetUserProfileBloc extends Bloc<GetUserProfileEvent, GetUserProfileState> {
  final GetUserProfileRepository getUserProfileRepository;
  final String token;

  GetUserProfileBloc(this.getUserProfileRepository, this.token) : super(UserProfileInitial()) {
    on<FetchUserProfileEvent>(_onFetchUserProfile);
  }

  Future<void> _onFetchUserProfile(FetchUserProfileEvent event, Emitter<GetUserProfileState> emit) async {
    print('FetchUserProfileEvent received'); // Debugging
    emit(UserProfileLoading());
    try {
      final profile = await getUserProfileRepository.fetchProfile(token);
      emit(UserProfileLoaded(profile));
      print('Profile loaded: $profile'); // Debugging
    } catch (e) {
      emit(UserProfileError(e.toString()));
      print('Error: $e'); // Debugging
    }
  }
}






