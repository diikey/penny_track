import 'package:flutter/material.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/data/local/local_data.dart';
import 'package:penny_track/data/repositories/records/records_repository.dart';
import 'package:penny_track/ui/accounts/accounts_screen.dart';
import 'package:penny_track/ui/analysis/analysis_screen.dart';
import 'package:penny_track/ui/budgets/budgets_screen.dart';
import 'package:penny_track/ui/categories/categories_screen.dart';
import 'package:penny_track/ui/records/records_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;
  final List<String> titles = [
    "Records",
    "Analysis",
    "Budgets",
    "Reports",
    "Categories",
  ];

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalData>(create: (context) {
          return LocalData();
        }),
        RepositoryProvider<RecordsRepository>(create: (context) {
          return RecordsRepository(context.read<LocalData>());
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return RecordsBloc(context.read<RecordsRepository>());
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(titles[currentIndex]),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  //todo go to search page
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: IndexedStack(
            index: currentIndex,
            children: <Widget>[
              const RecordsScreen(),
              const AnalysisScreen(),
              const BudgetsScreen(),
              const AccountsScreen(),
              const CategoriesScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: NavigationBar(
              onDestinationSelected: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              selectedIndex: currentIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.list_alt),
                  label: 'Records',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart),
                  label: 'Analysis',
                ),
                NavigationDestination(
                  icon: Icon(Icons.attach_money),
                  label: 'Budgets',
                ),
                // Text(''), // use this when centering the floating action button
                NavigationDestination(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Reports',
                ),
                NavigationDestination(
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
              ]),
        ),
      ),
    );
  }
}
