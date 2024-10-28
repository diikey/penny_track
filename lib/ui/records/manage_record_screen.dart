import 'package:flutter/material.dart';
import 'package:penny_track/data/dto/records/record.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
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
          )
        ],
      ),
    );
  }
}
