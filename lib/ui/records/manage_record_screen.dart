import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/repositories/records/records_repository.dart';
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

  void _changeRecordType(RecordType selectedRecordType) {
    setState(() {
      recordType = selectedRecordType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.close),
              Text("CANCEL"),
            ],
          ),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check),
                Text("SAVE"),
              ],
            ),
          ),
        ],
      ),
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LocalData>(create: (context) {
            return LocalData();
          }),
          RepositoryProvider<RecordsRepository>(create: (context) {
            return RecordsRepository(context.read<LocalData>());
          }),
        ],
        child: BlocProvider(
          create: (context) => RecordsBloc(context.read<RecordsRepository>()),
          child: BlocListener<RecordsBloc, RecordsState>(
            listener: (context, state) {
              if (state is RecordsFailedLocal) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            child: Padding(
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Select an account"),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: 2,
                                      // hitTestBehavior: HitTestBehavior.opaque,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            //select an account
                                            Navigator.pop(context);
                                          },
                                          title: Text("Cart"),
                                          trailing: Text("PHP 0.00"),
                                          contentPadding: EdgeInsets.all(10),
                                        );
                                      },
                                    ),
                                  ),
                                  // ElevatedButton(onPressed: (){
                                  //   //add new account feature?
                                  // }, child: Text("Add new Account")),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
                                "Choose an Account",
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
                          onTap: () {
                            print("choose to>>>");
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
                                      "Choose an Account",
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
                    controller: null,
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
                  BlocBuilder<RecordsBloc, RecordsState>(
                    builder: (context, state) {
                      if (state is RecordsLoadingLocal) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          context.read<RecordsBloc>().add(
                                RecordsAddEvent(
                                  Record(
                                      id: Uuid().v4(),
                                      recordAccount: "credit card",
                                      recordAmount: 1000,
                                      recordCreatedAt:
                                          GeneralUtils.convertDateTime(
                                              dateTime: DateTime.now()),
                                      recordNotes: "sample record notes",
                                      recordType: recordType.name),
                                ),
                              );
                        },
                        child: Text("Add Record"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
