import 'package:flutter/material.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/cubit/datepicker/datepicker_cubit.dart';
import 'package:penny_track/utils/general_utils.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';
import 'package:penny_track/utils/widgets/month_year_dialog.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override
  void initState() {
    context.read<RecordsBloc>().add(RecordsInitialGetEvent(
        GeneralUtils.convertDateTime(
            dateTime: DateTime.now(), format: "yyyy-MM")));
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecordsBloc, RecordsState>(
      listener: (context, state) {
        if (state is RecordsSuccessManage) {
          context.read<RecordsBloc>().add(RecordsInitialGetEvent(
              GeneralUtils.convertDateTime(
                  dateTime: selectedDate, format: "yyyy-MM")));
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: OutlinedButton(
              onPressed: () async {
                // _selectDate(context);
                final Map<String, int?>? result = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => DatepickerCubit(selectedDate),
                      child: MonthYearDialog(),
                    );
                  },
                );

                if (!context.mounted || result == null) return;
                setState(() {
                  selectedDate = DateTime(
                      result["selectedYear"]!, result["selectedMonth"]!);
                });
                context.read<RecordsBloc>().add(RecordsInitialGetEvent(
                    "${result["selectedYear"]!}-${result["selectedMonth"]!}"));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(GeneralUtils.convertDateTime(
                      dateTime: selectedDate, format: "MMMM, yyyy")),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<RecordsBloc, RecordsState>(
            builder: (context, state) {
              if (state is RecordsLoadingLocal) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is RecordsSuccessLocal) {
                if (state.records.isNotEmpty) {
                  List<Widget> groupedList = [];
                  String? currentDay;

                  for (var record in state.records) {
                    String day = GeneralUtils.convertDateString(
                        input: record.recordCreatedAt, format: "MMMM d, yyyy");

                    // Add a header if this record's month is different from the last
                    if (currentDay != day) {
                      currentDay = day;
                      groupedList.add(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            day,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }

                    // Add the record
                    groupedList.add(
                      ListTile(
                        onTap: () async {
                          final String? result = await Navigator.pushNamed(
                            context,
                            Routes.recordDetailsRoute,
                            arguments: record,
                          );

                          if (!context.mounted || result == null) return;
                          if (result == "success") {
                            context.read<RecordsBloc>().add(
                                RecordsInitialGetEvent(
                                    GeneralUtils.convertDateTime(
                                        dateTime: selectedDate,
                                        format: "yyyy-MM")));
                          }
                        },
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[400],
                          ),
                          child: Icon(
                            record.recordType.toLowerCase() == "income"
                                ? Icons.arrow_upward
                                : record.recordType.toLowerCase() == "expense"
                                    ? Icons.arrow_downward
                                    : Icons.swap_vert,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(GeneralUtils.convertDateString(
                            input: record.recordCreatedAt,
                            format: "MMM dd, yyyy")),
                        subtitle: Text(
                          record.recordType == "transfer"
                              ? "${record.recordAccount} > ${record.recordAccountTransfer}"
                              : "${record.recordAccount}${record.recordNotes == "" ? "" : " - ${record.recordNotes}"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        trailing: Text(
                          GeneralUtils.convertDoubleToMoney(
                              amount: record.recordAmount),
                          style: TextStyle(
                            color: record.recordType == "income"
                                ? Colors.green
                                : record.recordType == "expense"
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView(
                      children: groupedList,
                    ),
                  );
                }
              }
              return Expanded(
                child: Center(
                  child: Text("No Records."),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
