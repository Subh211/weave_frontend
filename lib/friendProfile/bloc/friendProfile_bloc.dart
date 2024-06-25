
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_event.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_repository.dart';
import 'package:weave_frontend/friendProfile/bloc/friendProfile_state.dart';
//
//
// class GetFriendProfileBloc extends Bloc<GetFriendProfileEvent, GetFriendProfileState> {
//   final GetFriendProfileRepository getFriendProfileRepository;
//   //final String token;
//
//   GetFriendProfileBloc(this.getFriendProfileRepository,
//       //this.token
//       ) : super(FriendProfileInitial()) {
//     on<FetchFriendProfileEvent>(_onFetchFriendProfile);
//   }
//
//   Future<void> _onFetchFriendProfile(FetchFriendProfileEvent event, Emitter<GetFriendProfileState> emit) async {
//     print('FetchUserProfileEvent received'); // Debugging
//     emit(FriendProfileLoading());
//     try {
//       final profile = await getFriendProfileRepository.fetchProfile(
//         //token
//       );
//       emit(FriendProfileLoaded(profile));
//       print('Profile loaded: $profile'); // Debugging
//     } catch (e) {
//       emit(FriendProfileError(e.toString()));
//       print('Error: $e'); // Debugging
//     }
//   }
// }
//
//
//
//
//
//


//
// class GetFriendProfileBloc extends Bloc<GetFriendProfileEvent, GetFriendProfileState> {
//   final GetFriendProfileRepository getFriendProfileRepository;
//
//   GetFriendProfileBloc(this.getFriendProfileRepository) : super(FriendProfileInitial()) {
//     on<FetchFriendProfileEvent>(_onFetchFriendProfile);
//   }
//
//   Future<void> _onFetchFriendProfile(FetchFriendProfileEvent event, Emitter<GetFriendProfileState> emit) async {
//     print('FetchUserProfileEvent received'); // Debugging
//     emit(FriendProfileLoading());
//     try {
//       final profile = await getFriendProfileRepository.fetchProfile(event.friendId); // Pass event.friendId
//       emit(FriendProfileLoaded(profile));
//       print('Profile loaded: $profile'); // Debugging
//     } catch (e) {
//       emit(FriendProfileError(e.toString()));
//       print('Error: $e'); // Debugging
//     }
//   }
// }
//




class GetFriendProfileBloc extends Bloc<GetFriendProfileEvent, GetFriendProfileState> {
  final GetFriendProfileRepository getFriendProfileRepository;

  GetFriendProfileBloc(this.getFriendProfileRepository) : super(FriendProfileInitial()) {
    on<FetchFriendProfileEvent>(_onFetchFriendProfile);
  }

  Future<void> _onFetchFriendProfile(FetchFriendProfileEvent event, Emitter<GetFriendProfileState> emit) async {
    print('FetchUserProfileEvent received'); // Debugging
    emit(FriendProfileLoading());
    try {
      final profile = await getFriendProfileRepository.fetchProfile(event.friendId); // Pass event.friendId
      emit(FriendProfileLoaded(profile));
      print('Profile loaded: $profile'); // Debugging
    } catch (e) {
      emit(FriendProfileError(e.toString()));
      print('Error: $e'); // Debugging
    }
  }
}

