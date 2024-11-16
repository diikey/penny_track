import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/dto/accounts/auth.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/remote/remote_data.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository_source.dart';
import 'package:penny_track/utils/general_utils.dart';

class AccountsRepository implements AccountsRepositorySource {
  final LocalData _localData;
  final RemoteData _remoteData;

  const AccountsRepository(this._localData, this._remoteData);

  @override
  Future<List<Account>> getAccounts() async {
    return await _localData.getAccounts();
  }

  @override
  Future<List<Account>> getCalculatedAccounts() async {
    return await _localData.getCalculatedAccounts();
  }

  @override
  Future<int> manageAccount(
      {required Account account, required Crud flag}) async {
    return await _localData.manageAccount(account: account, flag: flag);
  }

  @override
  Future<Auth> getAuthCode() async {
    return await _remoteData.getAuthCode();
  }

  @override
  Future<void> getTokenCode({required Auth auth}) async {
    await _remoteData.getTokenCode(auth: auth);
  }
}
