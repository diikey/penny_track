import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/utils/general_utils.dart';

abstract class AccountsRepositorySource {
  Future<List<Account>> getAccounts();

  Future<int> manageAccount({required Account account, required Crud flag});
}
