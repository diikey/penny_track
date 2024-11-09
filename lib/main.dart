import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository.dart';
import 'package:penny_track/data/repositories/records/records_repository.dart';
import 'package:penny_track/utils/cache.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider<Cache>(create: (context) => Cache(sharedPreferences)),
    RepositoryProvider<LocalData>(create: (context) => LocalData()),
    RepositoryProvider<RecordsRepository>(
        create: (context) => RecordsRepository(context.read<LocalData>())),
    RepositoryProvider<AccountsRepository>(
        create: (context) => AccountsRepository(context.read<LocalData>()))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penny Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
