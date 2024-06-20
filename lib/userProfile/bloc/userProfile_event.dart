// abstract class GetUserProfileEvent {}
//
// class FetchUserProfileEvent extends GetUserProfileEvent {}

//
// import 'package:equatable/equatable.dart';
//
// abstract class GetUserProfileEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class FetchUserProfileEvent extends GetUserProfileEvent {}



import 'package:equatable/equatable.dart';

abstract class GetUserProfileEvent  {}

class FetchUserProfileEvent extends GetUserProfileEvent {}