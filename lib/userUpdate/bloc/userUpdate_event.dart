import 'dart:io';
import 'package:equatable/equatable.dart';


abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserButtonPressed extends UpdateUserEvent {
  final String displayName;
  final String bio;
  final File? photoURL;


  const UpdateUserButtonPressed({
    required this.displayName,
    required this.bio,
    this.photoURL,
  });

  @override
  List<Object> get props => [
    displayName,
    photoURL?.path ?? 'null',
  ];
}

