import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/cubit/datepicker/datepicker_cubit.dart';

class MonthYearDialog extends StatefulWidget {
  const MonthYearDialog({super.key});

  @override
  State<MonthYearDialog> createState() => _MonthYearDialogState();
}

class _MonthYearDialogState extends State<MonthYearDialog> {
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    final datePickerCubit = context.read<DatepickerCubit>();
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocBuilder<DatepickerCubit, DatepickerState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: IconButton(
                          onPressed: () {
                            datePickerCubit.changeYear(YearFlag.decrement);
                          },
                          icon: Icon(Icons.chevron_left),
                        ),
                      ),
                      Text(state.year.toString()),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: IconButton(
                          onPressed: () {
                            datePickerCubit.changeYear(YearFlag.increment);
                          },
                          icon: Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                      children: List.generate(
                        months.length,
                        (index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              datePickerCubit.changeMonth(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: state.month == index
                                      ? Colors.amber
                                      : null,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(months[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context, {
                              "selectedMonth": state.month! + 1,
                              "selectedYear": state.year,
                            });
                          },
                          icon: Icon(Icons.check),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
