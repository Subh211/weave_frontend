import 'dart:io';
import 'package:equatable/equatable.dart';


abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostButtonPressed extends AddPostEvent {
  final String caption;
  final File? image;


  const AddPostButtonPressed({
    required this.caption,
    this.image,
  });

  @override
  List<Object> get props => [
    caption,
    image?.path ?? 'null',
  ];
}

