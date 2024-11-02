import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penny_track/data/repositories/records/records_repository.dart';
import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/utils/general_utils.dart';

part 'records_event.dart';
part 'records_state.dart';

class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final RecordsRepository recordsRepository;
  RecordsBloc(this.recordsRepository) : super(RecordsInitial()) {
    on<RecordsInitialGetEvent>(_onRecordsInitialGetEvent);
    on<RecordsManageEvent>(_onRecordsManageEvent);
  }

  void _onRecordsInitialGetEvent(
      RecordsInitialGetEvent event, Emitter<RecordsState> emit) async {
    emit(RecordsLoadingLocal());
    try {
      final List<Record> records = await recordsRepository.getRecords();
      emit(RecordsSuccessLocal(records));
    } catch (e) {
      emit(RecordsFailedLocal(e.toString()));
    }
  }

  void _onRecordsManageEvent(
      RecordsManageEvent event, Emitter<RecordsState> emit) async {
    emit(RecordsLoadingLocal());
    try {
      final int result = await recordsRepository.manageRecord(
          record: event.record, flag: event.flag);

      if (result == -1) {
        emit(RecordsFailedLocal("failed to manage record"));
      } else {
        emit(RecordsSuccessManage());
      }
    } catch (e) {
      emit(RecordsFailedLocal("Failed to manage record"));
    }
  }

  @override
  void onChange(Change<RecordsState> change) {
    print(change);
    super.onChange(change);
  }
}
