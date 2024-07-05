import 'package:equatable/equatable.dart';

abstract class AlluserEvent extends Equatable{
  const AlluserEvent();

  @override
  List<Object?> get props => [];
}

class GetAllUser extends AlluserEvent{}