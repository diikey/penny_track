part of 'records_bloc.dart';

sealed class RecordsState extends Equatable {
  const RecordsState();

  @override
  List<Object> get props => [];
}

final class RecordsInitial extends RecordsState {
  const RecordsInitial();
}

final class RecordsLoadingLocal extends RecordsState {
  const RecordsLoadingLocal();
}

final class RecordsSuccessLocal extends RecordsState {
  final List<Record> records;
  const RecordsSuccessLocal(this.records);
}

final class RecordsFailedLocal extends RecordsState {
  final String errorMessage;
  const RecordsFailedLocal(this.errorMessage);
}
