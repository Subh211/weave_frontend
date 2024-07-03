import 'package:equatable/equatable.dart';


abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordButtonPressed({
    required this.oldPassword,
    required this.newPassword,
    });

  @override
  List<Object> get props => [oldPassword, newPassword];
}

