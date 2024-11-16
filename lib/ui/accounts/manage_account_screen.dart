import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/accounts/accounts_bloc.dart';
import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/dto/accounts/auth.dart';
import 'package:penny_track/ui/accounts/widgets/auth_web_modal.dart';
import 'package:penny_track/utils/general_utils.dart';
import 'package:uuid/uuid.dart';

class ManageAccountScreen extends StatefulWidget {
  final Account? account;

  const ManageAccountScreen({super.key, this.account});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Account? account = widget.account;
    if (account != null) {
      nameController.text = account.accountName;
      amountController.text = account.accountAmount.toString();
    }

    return BlocListener<AccountsBloc, AccountsState>(
      listener: (context, state) async {
        if (state is AccountsFailed) {
          GeneralUtils.showSnackBar(context, state.errorMessage);
        }
        if (state is AccountsSuccessGrant) {
          final String? result = await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AuthWebModal(auth: state.auth);
            },
          );

          if (!context.mounted || result == null) return;
          if (result.contains("error")) {
            print("error daw p[ota>>>>$result");
            return;
          }
          context.read<AccountsBloc>().add(AccountsAuthTokenEvent(
              Auth(grant: state.auth.grant, redirectUrl: Uri.parse(result))));
        }
        if (state is AccountsSuccessManage) {
          Navigator.pop(context, "success");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          title: Text("Manage Account"),
          centerTitle: true,
          actions: [
            BlocBuilder<AccountsBloc, AccountsState>(builder: (context, state) {
              if (account == null) return Container();
              return IconButton(
                onPressed: () {
                  _manageAccount(
                      context: context, flag: Crud.delete, account: account);
                },
                icon: Icon(Icons.delete),
              );
            }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Account Name"),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: "Enter account name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Set Initial Amount"),
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: "0.00",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<AccountsBloc, AccountsState>(
                builder: (context, state) {
                  if (state is AccountsLoading ||
                      state is AccountsSuccessGrant) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) {
                        // todo handle text fields error
                        return;
                      }

                      _manageAccount(
                          context: context,
                          flag: account != null ? Crud.update : Crud.create,
                          account: account);
                    },
                    child: Text("Save Account"),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Or"),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              BlocBuilder<AccountsBloc, AccountsState>(
                  builder: (context, state) {
                if (state is AccountsLoading || state is AccountsSuccessGrant) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<AccountsBloc>().add(AccountsAuthCodeEvent());
                  },
                  child: Text("Bind a Union Bank Account"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _manageAccount(
      {required BuildContext context, required Crud flag, Account? account}) {
    final newAccount = Account(
      id: account == null ? Uuid().v4() : account.id,
      accountAmount: double.parse(
          amountController.text.isNotEmpty ? amountController.text : "0.0"),
      accountName: nameController.text,
    );
    context.read<AccountsBloc>().add(AccountsManageEvent(
          newAccount,
          flag,
        ));
  }
}
