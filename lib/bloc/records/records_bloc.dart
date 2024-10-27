import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penny_track/data/repositories/records/records_repository.dart';
import 'package:penny_track/data/dto/records/record.dart';

part 'records_event.dart';
part 'records_state.dart';

class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final RecordsRepository recordsRepository;
  RecordsBloc(this.recordsRepository) : super(RecordsInitial()) {
    on<RecordsInitialGetEvent>(_onRecordsInitialGetEvent);
  }

  void _onRecordsInitialGetEvent(
      RecordsInitialGetEvent event, Emitter<RecordsState> emit) async {
    emit(RecordsInitial());
    try {
      final List<Record> records = await recordsRepository.getRecords();
      emit(RecordsSuccessLocal(records));
    } catch (e) {
      emit(RecordsFailedLocal(e.toString()));
    }
  }

  @override
  void onChange(Change<RecordsState> change) {
    print(change);
    super.onChange(change);
  }
}
