part of 'work_bloc.dart';

abstract class WorkEvent extends Equatable {
  const WorkEvent();
}


class CreateWork extends WorkEvent {
  @override
  List<Object?> get props => [];
}

class GetAllWorks extends WorkEvent {
  @override
  List<Object?> get props => [];
}