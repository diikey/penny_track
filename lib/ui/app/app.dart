import 'package:flutter/material.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/ui/accounts/accounts_screen.dart';
import 'package:penny_track/ui/analysis/analysis_screen.dart';
import 'package:penny_track/ui/budgets/budgets_screen.dart';
import 'package:penny_track/ui/categories/categories_screen.dart';
import 'package:penny_track/ui/records/records_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';

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
    "Accounts",
    "Categories",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () async {
          final String? result =
              await Navigator.pushNamed(context, Routes.manageRecordRoute)
                  as String?;

          if (!context.mounted || result == null) return;
          context.read<RecordsBloc>().add(RecordsInitialGetEvent());
        },
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
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.list_alt),
              label: titles[0],
            ),
            NavigationDestination(
              icon: const Icon(Icons.bar_chart),
              label: titles[1],
            ),
            NavigationDestination(
              icon: Icon(Icons.attach_money),
              label: titles[2],
            ),
            // Text(''), // use this when centering the floating action button
            NavigationDestination(
              icon: const Icon(Icons.account_balance_wallet),
              label: titles[3],
            ),
            NavigationDestination(
              icon: const Icon(Icons.category),
              label: titles[4],
            ),
          ]),
    );
  }
}
