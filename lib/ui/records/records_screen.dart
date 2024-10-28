import 'package:flutter/material.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      return ListTile(
                        title: Text("qweqweqwe"),
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
