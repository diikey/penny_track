import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/accounts/accounts_bloc.dart';
import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/utils/general_utils.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  void initState() {
    context.read<AccountsBloc>().add(AccountsGetCalculatedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text("Net Assets"),
              if (state is AccountsLoading)
                Center(child: CircularProgressIndicator()),
              if (state is AccountsSuccess)
                Text(
                  _computeTotalAsset(state.accounts),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft, child: Text("Accounts")),
              SizedBox(
                height: 10,
              ),
              if (state is AccountsLoading)
                Center(child: CircularProgressIndicator()),
              if (state is AccountsSuccess)
                if (state.accounts.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: state.accounts.length,
                      itemBuilder: (context, index) {
                        final account = state.accounts[index];
                        return ListTile(
                          onTap: () {
                            _navigateToManageAccount(
                                context: context, account: account);
                          },
                          title: Text(account.accountName),
                          subtitle: Text(
                            "inital amount: ${GeneralUtils.convertDoubleToMoney(amount: account.accountAmount)}",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          trailing: Text(
                            GeneralUtils.convertDoubleToMoney(
                                amount: account.accountCurrentAmount!),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: Center(
                      child: Text("No Accounts."),
                    ),
                  ),
              ElevatedButton(
                onPressed: () {
                  _navigateToManageAccount(context: context);
                },
                child: Text("ADD AN ACCOUNT"),
              ),
            ],
          ),
        );
      },
    );
  }

  String _computeTotalAsset(List<Account> accounts) {
    double totalAmount = 0.0;

    for (final element in accounts) {
      totalAmount += element.accountCurrentAmount!;
    }

    return GeneralUtils.convertDoubleToMoney(amount: totalAmount);
  }

  void _navigateToManageAccount(
      {required BuildContext context, Account? account}) async {
    final String? result = await Navigator.pushNamed(
      context,
      Routes.manageAccountRoute,
      arguments: account,
    ) as String?;

    if (!context.mounted || result == null) return;
    if (result == "success") {
      context.read<AccountsBloc>().add(AccountsGetCalculatedEvent());
    }
  }
}
