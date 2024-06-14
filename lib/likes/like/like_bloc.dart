// // import 'dart:io';
// //
// // import 'package:bloc/bloc.dart';
// // import 'package:dio/dio.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:weave_frontend/models/postModel.dart';
// // import 'package:weave_frontend/likes/like/like_event.dart';
// // import 'package:weave_frontend/likes/like/like_state.dart';
// //
// // class LikeBloc extends Bloc<LikeEvent, LikeState> {
// //   final Dio dio;
// //   final String baseUrl;
// //   final FlutterSecureStorage secureStorage;
// //
// //   LikeBloc({required this.dio, required this.baseUrl, required this.secureStorage}) : super(LikeInitial());
// //
// //   @override
// //   Stream<LikeState> mapEventToState(LikeEvent event) async* {
// //     if (event is LikePost || event is UnlikePost) {
// //       yield LikeLoading();
// //
// //       final storedToken = await _getStoredToken();
// //       if (storedToken == null) {
// //         yield LikeFailure('Token is missing');
// //         return;
// //       }
// //
// //       final url = '$baseUrl/like/${event.friendId}?postId=${event.postId}';
// //
// //       try {
// //         final response = event is LikePost
// //             ? await dio.post(
// //           url,
// //           options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $storedToken'}),
// //         )
// //             : await dio.delete(
// //           url,
// //           options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $storedToken'}),
// //         );
// //
// //         if (response.statusCode == 200) {
// //           final post = Post.fromJson(response.data);
// //           yield LikeSuccess(post);
// //         } else {
// //           yield LikeFailure('Server error: ${response.statusCode}');
// //         }
// //       } catch (e) {
// //         yield LikeFailure('Network error: $e');
// //       }
// //     }
// //   }
// //
// //   Future<String?> _getStoredToken() async {
// //     return await secureStorage.read(key: 'token');
// //   }
// // }
//
//
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:weave_frontend/likes/like/like_event.dart';import 'package:weave_frontend/likes/like/like_state.dart';
// import 'dart:io';
// import '../../models/postModel.dart';
//
// // class LikeBloc extends Bloc<LikeEvent, LikeState> {
// //   final Dio dio;
// //   final String baseUrl;
// //   final FlutterSecureStorage secureStorage;
// //
// //   LikeBloc({required this.dio, required this.baseUrl, required this.secureStorage}) : super(LikeInitial());
// //
// //   @override
// //   Stream<LikeState> mapEventToState(LikeEvent event) async* {
// //     if (event is LikePost || event is UnlikePost) {
// //       yield LikeLoading();
// //
// //       final storedToken = await _getStoredToken();
// //       if (storedToken == null) {
// //         yield LikeFailure('Token is missing');
// //         return;
// //       }
// //
// //       final String url;
// //       final Options options = Options(
// //         headers: {HttpHeaders.authorizationHeader: 'Bearer $storedToken'},
// //       );
// //
// //       try {
// //         Response response;
// //
// //         if (event is LikePost) {
// //           url = '$baseUrl/like/${event.friendId}?postId=${event.postId}';
// //           response = await dio.post(url, options: options);
// //         } else if (event is UnlikePost) {
// //           url = '$baseUrl/like/${event.friendId}?postId=${event.postId}';
// //           response = await dio.delete(url, options: options);
// //         } else {
// //           throw Exception('Invalid event type');
// //         }
// //
// //         if (response.statusCode == 200) {
// //           final post = Post.fromJson(response.data);
// //           yield LikeSuccess(post);
// //         } else {
// //           yield LikeFailure('Server error: ${response.statusCode}');
// //         }
// //       } catch (e) {
// //         yield LikeFailure('Network error: $e');
// //       }
// //     }
// //   }
// //
// //   Future<String?> _getStoredToken() async {
// //     return await secureStorage.read(key: 'token');
// //   }
// // }
//
//
// class LikeBloc extends Bloc<LikeEvent, LikeState> {
//   final Dio dio;
//   final String baseUrl;
//   final FlutterSecureStorage secureStorage;
//
//   LikeBloc({required this.dio, required this.baseUrl, required this.secureStorage}) : super(LikeInitial()) {
//     on<LikePost>(_onLikePost);
//     on<UnlikePost>(_onUnlikePost);
//   }
//
//   Future<void> _onLikePost(LikePost event, Emitter<LikeState> emit) async {
//     emit(LikeLoading());
//     final storedToken = await _getStoredToken();
//     if (storedToken == null) {
//       emit(LikeFailure('Token is missing'));
//       return;
//     }
//     try {
//       final response = await dio.post(
//         '$baseUrl/like/${event.friendId}',
//         queryParameters: {'postId': event.postId},
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: 'Bearer $storedToken',
//           },
//         ),
//       );
//       final updatedPost = Post.fromJson(response.data);
//       emit(LikeSuccess(updatedPost));
//     } catch (e) {
//       emit(LikeFailure('Failed to like post'));
//     }
//   }
//
//   Future<void> _onUnlikePost(UnlikePost event, Emitter<LikeState> emit) async {
//     emit(LikeLoading());
//     final storedToken = await _getStoredToken();
//     if (storedToken == null) {
//       emit(LikeFailure('Token is missing'));
//       return;
//     }
//     try {
//       final response = await dio.delete(
//         '$baseUrl/like/${event.friendId}',
//         queryParameters: {'postId': event.postId},
//         options: Options(
//           headers: {
//             HttpHeaders.authorizationHeader: 'Bearer $storedToken',
//           },
//         ),
//       );
//       final updatedPost = Post.fromJson(response.data);
//       emit(LikeSuccess(updatedPost));
//     } catch (e) {
//       emit(LikeFailure('Failed to unlike post'));
//     }
//   }
//
//   Future<String?> _getStoredToken() async {
//     final storedToken = await secureStorage.read(key: 'token');
//     return storedToken;
//   }
// }