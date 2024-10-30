import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/repositories/records/records_repository_source.dart';

class RecordsRepository implements RecordsRepositorySource {
  final LocalData _localData;

  RecordsRepository(this._localData);

  @override
  Future<List<Record>> getRecords() async {
    return _localData.getRecords();
  }

  @override
  Future<int> addRecord({required Record record}) {
    return _localData.addRecord(record: record);
  }
}
