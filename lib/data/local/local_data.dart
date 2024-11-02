import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/local/local_data_source.dart';
import 'package:penny_track/database/dbhelper.dart';

import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/utils/general_utils.dart';

class LocalData implements LocalDataSource {
  final _dbhelper = DBHelper.instance;

  ///records
  @override
  Future<List<Record>> getRecords() async {
    return await _dbhelper.getRecords();
  }

  @override
  Future<int> manageRecord({required Record record, required Crud flag}) async {
    switch (flag) {
      case Crud.create:
        return await _dbhelper.addRecord(record);
      case Crud.update:
        return await _dbhelper.updateRecord(record);
      case Crud.delete:
        return await _dbhelper.deleteRecord(record);
      default:
        return -1;
    }
  }

  ///accounts
  @override
  Future<List<Account>> getAccounts() async {
    return await _dbhelper.getAccounts();
  }

  @override
  Future<int> manageAccount(
      {required Account account, required Crud flag}) async {
    switch (flag) {
      case Crud.create:
        return await _dbhelper.addAccount(account);
      case Crud.update:
        return await _dbhelper.updateAccount(account);
      case Crud.delete:
        return await _dbhelper.deleteAccount(account);
      default:
        return -1;
    }
  }
}
