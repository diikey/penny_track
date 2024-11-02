import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/accounts/accounts_bloc.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository.dart';
import 'package:penny_track/ui/records/widgets/choose_account_modal.dart';
import 'package:penny_track/utils/general_utils.dart';
import 'package:uuid/uuid.dart';

class ManageRecordScreen extends StatefulWidget {
  final Record? record;

  const ManageRecordScreen({super.key, this.record});

  @override
  State<ManageRecordScreen> createState() => _ManageRecordScreenState();
}

enum RecordType { income, expense, transfer }

class _ManageRecordScreenState extends State<ManageRecordScreen> {
  RecordType recordType = RecordType.expense;
  String? selectedAccount;
  String? selectedAccountTransfer;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    if (widget.record != null) {
      final Record record = widget.record!;
      final RecordType initRecordType;
      switch (record.recordType) {
        case "income":
          initRecordType = RecordType.income;
          break;
        case "expense":
          initRecordType = RecordType.expense;
          break;
        default:
          initRecordType = RecordType.transfer;
          break;
      }

      setState(() {
        recordType = initRecordType;
        selectedAccount = record.recordAccount;
        selectedAccountTransfer = record.recordAccountTransfer;
        amountController.text = record.recordAmount.toString();
        notesController.text = record.recordNotes;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Record? record = widget.record;
    return BlocListener<RecordsBloc, RecordsState>(
      listener: (context, state) {
        if (state is RecordsFailedLocal) {
          GeneralUtils.showSnackBar(context, state.errorMessage);
        }
        if (state is RecordsSuccessManage) {
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      if (recordType == RecordType.income)
                        Icon(Icons.check_circle),
                      TextButton(
                        onPressed: () {
                          _changeRecordType(RecordType.income);
                        },
                        child: Text("INCOME"),
                      ),
                    ],
                  ),
                  Text("|"),
                  Row(
                    children: [
                      if (recordType == RecordType.expense)
                        Icon(Icons.check_circle),
                      TextButton(
                        onPressed: () {
                          _changeRecordType(RecordType.expense);
                        },
                        child: Text("EXPENSE"),
                      ),
                    ],
                  ),
                  Text("|"),
                  Row(
                    children: [
                      if (recordType == RecordType.transfer)
                        Icon(Icons.check_circle),
                      TextButton(
                        onPressed: () {
                          _changeRecordType(RecordType.transfer);
                        },
                        child: Text("TRANSFER"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  final String? result = await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider<AccountsBloc>(
                        create: (context) =>
                            AccountsBloc(context.read<AccountsRepository>()),
                        child: ChooseAccountModal(),
                      );
                    },
                  );

                  if (!context.mounted || result == null) return;
                  _setAccount(accountName: result);
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recordType == RecordType.transfer
                                ? "From"
                                : "Account",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            selectedAccount ?? "Choose an Account",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
              if (recordType == RecordType.transfer)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final String? result = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider<AccountsBloc>(
                              create: (context) => AccountsBloc(
                                  context.read<AccountsRepository>()),
                              child: ChooseAccountModal(),
                            );
                          },
                        );

                        if (!context.mounted || result == null) return;
                        _setAccount(accountName: result, flag: "transfer");
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  selectedAccountTransfer ??
                                      "Choose an account",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Amount"),
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
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Notes"),
              ),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: "Leave notes...",
                ),
                maxLines: 3,
                maxLength: 200,
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<RecordsBloc, RecordsState>(
                builder: (context, state) {
                  if (state is RecordsLoadingLocal) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (!_validateSave(context)) return;
                      context.read<RecordsBloc>().add(
                            RecordsManageEvent(
                              Record(
                                  id: record != null ? record.id : Uuid().v4(),
                                  recordAccount: selectedAccount!,
                                  recordAccountTransfer:
                                      selectedAccountTransfer,
                                  recordAmount:
                                      double.parse(amountController.text),
                                  recordCreatedAt: GeneralUtils.convertDateTime(
                                      dateTime: DateTime.now()),
                                  recordNotes: notesController.text,
                                  recordType: recordType.name),
                              record != null ? Crud.update : Crud.create,
                            ),
                          );
                    },
                    child: Text("Save Record"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeRecordType(RecordType selectedRecordType) {
    setState(() {
      recordType = selectedRecordType;
    });
  }

  void _setAccount({required String accountName, String? flag}) {
    setState(() {
      if (flag == "transfer") {
        selectedAccountTransfer = accountName;
      } else {
        selectedAccount = accountName;
      }
    });
  }

  bool _validateSave(BuildContext context) {
    if (selectedAccount == null || amountController.text.isEmpty) return false;
    if (recordType == RecordType.transfer && selectedAccountTransfer == null) {
      return false;
    }
    if (selectedAccount == selectedAccountTransfer) {
      GeneralUtils.showSnackBar(context, "Cannot transfer to same account.");
      return false;
    }
    return true;
  }
}
