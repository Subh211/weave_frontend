import 'dart:io';
import 'package:equatable/equatable.dart';


abstract class SignOutEvent extends Equatable {
  const SignOutEvent();

  @override
  List<Object> get props => [];
}

class SignOutButtonPressed extends SignOutEvent {
  final String email;
  final String password;

  const SignOutButtonPressed({
    required this.email,
    required this.password});

  @override
  List<Object> get props => [email, password];
}

