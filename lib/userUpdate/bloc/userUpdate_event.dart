import 'dart:io';
import 'package:equatable/equatable.dart';


abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserButtonPressed extends UpdateUserEvent {
  final String displayName;
  final File? photoURL;


  const UpdateUserButtonPressed({

     required this.displayName,
     this.photoURL,
  });

  @override
  List<Object> get props => [
    displayName,
    photoURL?.path ?? 'null',
  ];
}

