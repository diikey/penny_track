import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/dto/accounts/auth.dart';
import 'package:penny_track/utils/general_utils.dart';

abstract class AccountsRepositorySource {
  Future<List<Account>> getAccounts();
  Future<List<Account>> getCalculatedAccounts();
  Future<int> manageAccount({required Account account, required Crud flag});
  Future<Auth> getAuthCode();
  Future<void> getTokenCode({required Auth auth});
}
