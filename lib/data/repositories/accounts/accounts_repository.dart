import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository_source.dart';
import 'package:penny_track/utils/general_utils.dart';

class AccountsRepository implements AccountsRepositorySource {
  final LocalData _localData;

  const AccountsRepository(this._localData);

  @override
  Future<List<Account>> getAccounts() async {
    return await _localData.getAccounts();
  }

  @override
  Future<int> manageAccount({required Account account, required Crud flag}) async {
    return await _localData.manageAccount(account: account, flag: flag);
  }
}
