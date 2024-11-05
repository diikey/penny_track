import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/repositories/records/records_repository_source.dart';
import 'package:penny_track/utils/general_utils.dart';

class RecordsRepository implements RecordsRepositorySource {
  final LocalData _localData;

  RecordsRepository(this._localData);

  @override
  Future<List<Record>> getRecords() async {
    return await _localData.getRecords();
  }

  @override
  Future<List<Record>> getRecordsByDate({required String date}) async {
    return await _localData.getRecordsByDate(date: date);
  }

  @override
  Future<int> manageRecord({required Record record, required Crud flag}) async {
    return await _localData.manageRecord(record: record, flag: flag);
  }
}
