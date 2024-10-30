import 'package:penny_track/data/dto/records/record.dart';

abstract class RecordsRepositorySource {
  Future<List<Record>> getRecords();
  Future<int> addRecord({required Record record});
}
