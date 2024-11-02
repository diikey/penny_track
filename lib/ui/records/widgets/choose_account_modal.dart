import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/accounts/accounts_bloc.dart';
import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/utils/general_utils.dart';

class ChooseAccountModal extends StatefulWidget {
  const ChooseAccountModal({super.key});

  @override
  State<ChooseAccountModal> createState() => _ChooseAccountModalState();
}

class _ChooseAccountModalState extends State<ChooseAccountModal> {
  @override
  void initState() {
    context.read<AccountsBloc>().add(AccountsGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Select an account"),
            BlocBuilder<AccountsBloc, AccountsState>(
              builder: (context, state) {
                if (state is AccountsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AccountsSuccess && state.accounts.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.accounts.length,
                      // hitTestBehavior: HitTestBehavior.opaque,
                      itemBuilder: (context, index) {
                        final Account account = state.accounts[index];
                        return ListTile(
                          onTap: () {
                            //select an account
                            Navigator.pop(context, account);
                          },
                          title: Text(account.accountName),
                          trailing: Text(GeneralUtils.convertDoubleToMoney(
                              amount: account.accountAmount)),
                          contentPadding: EdgeInsets.all(10),
                        );
                      },
                    ),
                  );
                }
                return Expanded(
                  child: Center(
                    child: Text("No Accounts yet"),
                  ),
                );
              },
            ),
            // ElevatedButton(onPressed: (){
            //   //add new account feature?
            // }, child: Text("Add new Account")),
          ],
        ),
      ),
    );
  }
}
