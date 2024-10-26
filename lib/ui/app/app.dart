import 'package:flutter/material.dart';
import 'package:penny_track/ui/accounts/accounts_screen.dart';
import 'package:penny_track/ui/analysis/analysis_screen.dart';
import 'package:penny_track/ui/budgets/budgets_screen.dart';
import 'package:penny_track/ui/categories/categories_screen.dart';
import 'package:penny_track/ui/records/records_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: <Widget>[
        const RecordsScreen(),
        const AnalysisScreen(),
        const BudgetsScreen(),
        const AccountsScreen(),
        const CategoriesScreen(),
      ][currentIndex],
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
    );
  }
}
