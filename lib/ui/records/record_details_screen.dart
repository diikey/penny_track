import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/data/dto/records/record.dart';
import 'package:penny_track/utils/general_utils.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';

class RecordDetailsScreen extends StatelessWidget {
  final Record record;
  const RecordDetailsScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
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
          title: Text("Record Details"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context
                    .read<RecordsBloc>()
                    .add(RecordsManageEvent(record, Crud.delete));
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(_generateRecordTypeDetails(record: record))),
                  Expanded(
                      child: Text(
                    GeneralUtils.convertDoubleToMoney(
                        amount: record.recordAmount),
                    textAlign: TextAlign.end,
                  )),
                ],
              ),
              if (record.recordType == "transfer")
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _generateRecordTypeDetails(
                          record: record, flag: "transfer"),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 5),
                child: Text("Notes"),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  record.recordNotes == "" ? "-" : record.recordNotes,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: Text("Date")),
                  Expanded(
                      child: Text(
                    GeneralUtils.convertDateString(
                        input: record.recordCreatedAt, format: "MMM dd, yyyy"),
                    textAlign: TextAlign.end,
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final String? result = await Navigator.pushNamed(
                      context,
                      Routes.manageRecordRoute,
                      arguments: record,
                    );

                    if (!context.mounted || result == null) return;
                    Navigator.pop(context, result);
                  },
                  child: Text("Edit Record"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateRecordTypeDetails({required Record record, String? flag}) {
    final String recordType;

    if (flag == "transfer") {
      recordType =
          "${record.recordType[0].toUpperCase()}${record.recordType.substring(1)} to: ${record.recordAccountTransfer}";
    } else {
      recordType =
          "${record.recordType[0].toUpperCase()}${record.recordType.substring(1)} from: ${record.recordAccount}";
    }

    return recordType;
  }
}
