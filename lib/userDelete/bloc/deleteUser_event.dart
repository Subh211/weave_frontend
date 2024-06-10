import 'dart:io';
import 'package:equatable/equatable.dart';


abstract class DeleteUserEvent extends Equatable {
  const DeleteUserEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserButtonPressed extends DeleteUserEvent {
  final String password;

  const DeleteUserButtonPressed({
    required this.password,

  });

  @override
  List<Object> get props => [password];
}

