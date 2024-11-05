part of 'records_bloc.dart';

sealed class RecordsEvent extends Equatable {
  const RecordsEvent();

  @override
  List<Object> get props => [];
}

class RecordsInitialGetEvent extends RecordsEvent {
  final String dateQuery;
  const RecordsInitialGetEvent(this.dateQuery);
}

class RecordsManageEvent extends RecordsEvent {
  final Record record;
  final Crud flag;
  const RecordsManageEvent(this.record, this.flag);
}

class RecordsSetManageStateSuccess extends RecordsEvent {
  const RecordsSetManageStateSuccess();
}
