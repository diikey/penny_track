part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

final class AccountsGetEvent extends AccountsEvent {
  const AccountsGetEvent();
}

final class AccountsManageEvent extends AccountsEvent {
  final Account account;
  final Crud flag;

  const AccountsManageEvent(this.account, this.flag);
}
