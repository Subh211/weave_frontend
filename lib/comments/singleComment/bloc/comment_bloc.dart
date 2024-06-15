// // comment_bloc.dart
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'comment_event.dart';
// import 'comment_state.dart';
//
// class CommentBloc extends Bloc<CommentEvent, CommentState> {
//   final Dio _dio;
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   final String token;
//
//
//   CommentBloc(this._dio, this.token) : super(CommentInitial());
//
//   Future<String?> _getStoredToken() async {
//     final storedToken = await secureStorage.read(key: 'token');
//     return storedToken;
//   }
//
//   @override
//   Stream<CommentState> mapEventToState(CommentEvent event) async* {
//
//     if (event is DoCommentEvent) {
//       yield* _mapDoCommentEventToState(event);
//     }
//   }
//
//   Stream<CommentState> _mapDoCommentEventToState(DoCommentEvent event) async* {
//     yield CommentInProgress();
//     try {
//       final storedToken = await _getStoredToken();
//       if (storedToken == null) {
//         emit(CommentFailure(error: 'Token is missing'));
//         return;
//       }
//
//       final response = await _dio.post(
//         'https://weave-backend-pyfu.onrender.com/api/v1/post/comment/${event.friendId}?postId=${event.postId}',
//         data: {
//           'comment': event.comment, // Add other data as needed
//         },
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             HttpHeaders.authorizationHeader: 'Bearer $storedToken',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         yield CommentSuccess();
//       } else {
//         yield CommentFailure(error: 'Failed to post comment');
//       }
//     } catch (error) {
//       yield CommentFailure(error: error.toString());
//     }
//   }
// }
//


import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final Dio _dio;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final String token;

  CommentBloc(this._dio, this.token) : super(CommentInitial()) {
    on<DoCommentEvent>(_onDoCommentEvent); // Register the handler for DoCommentEvent
  }

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    return storedToken;
  }

  void _onDoCommentEvent(DoCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentInProgress());
    try {
      final storedToken = await _getStoredToken();
      if (storedToken == null) {
        emit(CommentFailure(error: 'Token is missing'));
        return;
      }

      final response = await _dio.post(
        'https://weave-backend-pyfu.onrender.com/api/v1/post/comment/${event.friendId}?postId=${event.postId}',
        data: {
          'comment': event.comment, // Add other data as needed
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $storedToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(CommentSuccess());
      } else {
        emit(CommentFailure(error: 'Failed to post comment'));
      }
    } catch (error) {
      emit(CommentFailure(error: error.toString()));
    }
  }
}
