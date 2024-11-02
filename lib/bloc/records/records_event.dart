part of 'records_bloc.dart';

sealed class RecordsEvent extends Equatable {
  const RecordsEvent();

  @override
  List<Object> get props => [];
}

class RecordsInitialGetEvent extends RecordsEvent {
  const RecordsInitialGetEvent();
}

class RecordsManageEvent extends RecordsEvent {
  final Record record;
  final Crud flag;
  const RecordsManageEvent(this.record, this.flag);
}
