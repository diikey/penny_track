import 'package:penny_track/data/local/local_data_source.dart';
import 'package:penny_track/database/dbhelper.dart';

import 'package:penny_track/data/dto/records/record.dart';

class LocalData implements LocalDataSource {
  final _dbhelper = DBHelper.instance;

  @override
  Future<List<Record>> getRecords() async {
    return await _dbhelper.getRecords();
  }

  @override
  Future<int> addRecord({required Record record}) async {
    return await _dbhelper.addRecord(record);
  }
}
