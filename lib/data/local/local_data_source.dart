import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/utils/general_utils.dart';

abstract class LocalDataSource {
  ///records
  Future<List<Record>> getRecords();
  Future<List<Record>> getRecordsByDate({required String date});
  Future<int> manageRecord({required Record record, required Crud flag});

  ///accounts
  Future<List<Account>> getAccounts();
  Future<List<Account>> getCalculatedAccounts();
  Future<int> manageAccount({required Account account, required Crud flag});
}
