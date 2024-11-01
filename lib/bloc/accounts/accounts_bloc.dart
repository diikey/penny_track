import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository.dart';
import 'package:penny_track/utils/general_utils.dart';

part 'accounts_event.dart';

part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AccountsRepository accountsRepository;

  AccountsBloc(this.accountsRepository) : super(AccountsInitial()) {
    on<AccountsGetEvent>(_onAccountsGetEvent);
    on<AccountsManageEvent>(_onAccountsManageEvent);
  }

  void _onAccountsGetEvent(
      AccountsGetEvent event, Emitter<AccountsState> emit) async {
    emit(AccountsLoading());
    try {
      final List<Account> accounts = await accountsRepository.getAccounts();
      emit(AccountsSuccess(accounts));
    } catch (e) {
      emit(AccountsFailed("failed to get accounts"));
    }
  }

  void _onAccountsManageEvent(
      AccountsManageEvent event, Emitter<AccountsState> emit) async {
    emit(AccountsLoading());
    try {
      final int result = await accountsRepository.manageAccount(
          account: event.account, flag: event.flag);
      if (result > 0) {
        emit(AccountsSuccessManage());
      } else {
        emit(AccountsFailed("failed to manage account"));
      }
    } catch (e) {
      emit(AccountsFailed("failed to manage account"));
    }
  }

  @override
  void onChange(Change<AccountsState> change) {
    print(change);
    super.onChange(change);
  }
}
