import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/utils/general_utils.dart';

abstract class RecordsRepositorySource {
  Future<List<Record>> getRecords();
  Future<int> manageRecord({required Record record, required Crud flag});
}
