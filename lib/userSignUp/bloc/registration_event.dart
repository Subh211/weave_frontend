import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegistrationEvent {
  final String email;
  final String name;
  final String password;
  final String confirmPassword;
  final String displayName;
  final String bio;
  final String photoURL;

  const RegisterUser({
    required this.email,
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.displayName,
    required this.bio,
    required this.photoURL,
  });

  @override
  List<Object> get props =>
      [email, name, password, confirmPassword, displayName, bio, photoURL];
}
