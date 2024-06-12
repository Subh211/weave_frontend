import 'dart:io';
import 'package:equatable/equatable.dart';


abstract class SignOutEvent extends Equatable {
  const SignOutEvent();

  @override
  List<Object> get props => [];
}

class SignOutButtonPressed extends SignOutEvent {


  @override
  List<Object> get props => [];
}

