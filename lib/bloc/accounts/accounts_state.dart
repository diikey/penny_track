part of 'accounts_bloc.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();

  @override
  List<Object> get props => [];
}

final class AccountsInitial extends AccountsState {
  const AccountsInitial();
}

final class AccountsLoading extends AccountsState {
  const AccountsLoading();
}

final class AccountsSuccess extends AccountsState {
  final List<Account> accounts;

  const AccountsSuccess(this.accounts);
}

final class AccountsFailed extends AccountsState {
  final String errorMessage;

  const AccountsFailed(this.errorMessage);
}

///for add states
final class AccountsSuccessManage extends AccountsState {
  const AccountsSuccessManage();
}

final class AccountsSuccessGrant extends AccountsState {
  final Auth auth;

  const AccountsSuccessGrant(this.auth);
}
