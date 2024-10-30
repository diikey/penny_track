part of 'records_bloc.dart';

sealed class RecordsEvent extends Equatable {
  const RecordsEvent();

  @override
  List<Object> get props => [];
}

class RecordsInitialGetEvent extends RecordsEvent {
  const RecordsInitialGetEvent();
}

class RecordsAddEvent extends RecordsEvent {
  final Record record;
  const RecordsAddEvent(this.record);
}
