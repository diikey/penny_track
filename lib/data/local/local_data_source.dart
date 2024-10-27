import 'package:penny_track/data/dto/records/record.dart';

abstract class LocalDataSource {
  Future<List<Record>> getRecords();
}
