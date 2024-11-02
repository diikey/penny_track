import 'package:flutter/material.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/data/dto/records/record.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/utils/general_utils.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override
  void initState() {
    context.read<RecordsBloc>().add(RecordsInitialGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_left),
              ),
            ),
            Text("October, 2024"),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
              ),
            ),
          ],
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
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.records.length,
                    itemBuilder: (context, index) {
                      final Record record = state.records[index];
                      return ListTile(
                        onTap: () async {
                          final String? result = await Navigator.pushNamed(
                            context,
                            Routes.recordDetailsRoute,
                            arguments: record,
                          );

                          if (!context.mounted || result == null) return;
                          if (result == "success") {
                            context
                                .read<RecordsBloc>()
                                .add(RecordsInitialGetEvent());
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
                            input: record.recordCreatedAt)),
                        subtitle: Text(
                          record.recordType == "transfer"
                              ? "${record.recordAccount} > ${record.recordAccountTransfer}"
                              : "${record.recordAccount}${record.recordNotes == "" ? "" : " - ${record.recordNotes}"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      );
                    },
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
    );
  }
}
