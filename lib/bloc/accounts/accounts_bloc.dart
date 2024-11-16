import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/dto/accounts/auth.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository.dart';
import 'package:penny_track/utils/general_utils.dart';

part 'accounts_event.dart';

part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final AccountsRepository accountsRepository;

  AccountsBloc(this.accountsRepository) : super(AccountsInitial()) {
    on<AccountsGetEvent>(_onAccountsGetEvent);
    on<AccountsGetCalculatedEvent>(_onAccountsGetCalculatedEvent);
    on<AccountsManageEvent>(_onAccountsManageEvent);
    on<AccountsAuthCodeEvent>(_onAccountsAuthCodeEvent);
    on<AccountsAuthTokenEvent>(_onAccountsAuthTokenEvent);
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

  void _onAccountsGetCalculatedEvent(
      AccountsGetCalculatedEvent event, Emitter<AccountsState> emit) async {
    emit(AccountsLoading());
    try {
      final List<Account> accounts =
          await accountsRepository.getCalculatedAccounts();
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

  void _onAccountsAuthCodeEvent(
      AccountsAuthCodeEvent event, Emitter<AccountsState> emit) async {
    emit(AccountsLoading());
    try {
      final Auth result = await accountsRepository.getAuthCode();
      if (result.grant != null && result.authorizationUrl != null) {
        emit(AccountsSuccessGrant(result));
      } else {
        emit(AccountsFailed(result.errorMessage!));
      }
    } catch (e) {
      emit(AccountsFailed("something went wrong"));
    }
  }

  void _onAccountsAuthTokenEvent(
      AccountsAuthTokenEvent event, Emitter<AccountsState> emit) async {
    try {
      await accountsRepository.getTokenCode(auth: event.auth);
    } catch (e) {
      //
    }
  }

  @override
  void onChange(Change<AccountsState> change) {
    print(change);
    super.onChange(change);
  }
}
