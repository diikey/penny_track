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
    return Container(
      child: const Text('Home Screen'),
    );
  }
}
