part of 'work_bloc.dart';

abstract class WorkState extends Equatable {
  const WorkState();
}

class WorkInitial extends WorkState {
  @override
  List<Object> get props => [];
}
