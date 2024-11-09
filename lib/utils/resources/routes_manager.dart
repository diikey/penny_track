import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/bloc/accounts/accounts_bloc.dart';
import 'package:penny_track/bloc/records/records_bloc.dart';
import 'package:penny_track/data/dto/accounts/account.dart';
import 'package:penny_track/data/repositories/accounts/accounts_repository.dart';
import 'package:penny_track/data/repositories/records/records_repository.dart';
import 'package:penny_track/ui/accounts/manage_account_screen.dart';
import 'package:penny_track/ui/app/app.dart';
import 'package:penny_track/ui/login/login_screen.dart';
import 'package:penny_track/ui/records/manage_record_screen.dart';
import 'package:penny_track/ui/records/record_details_screen.dart';
import 'package:penny_track/ui/splash/splash_screen.dart';
import 'package:penny_track/data/dto/records/record.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String appRoute = "/app";
  static const String manageRecordRoute = "/manage_record";
  static const String recordDetailsRoute = "/record_details";
  static const String manageAccountRoute = "/manage_account";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.appRoute:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    RecordsBloc(context.read<RecordsRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    AccountsBloc(context.read<AccountsRepository>()),
              ),
            ],
            child: App(),
          );
        });
      case Routes.manageRecordRoute:
        final Record? record = routeSettings.arguments as Record?;
        return MaterialPageRoute<String>(builder: (_) {
          return BlocProvider(
            create: (context) => RecordsBloc(context.read<RecordsRepository>()),
            child: ManageRecordScreen(
              record: record,
            ),
          );
        });
      case Routes.recordDetailsRoute:
        final Record record = routeSettings.arguments as Record;
        return MaterialPageRoute<String>(builder: (_) {
          return BlocProvider<RecordsBloc>(
            create: (context) => RecordsBloc(context.read<RecordsRepository>()),
            child: RecordDetailsScreen(record: record),
          );
        });
      case Routes.manageAccountRoute:
        final Account? account = routeSettings.arguments as Account?;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                AccountsBloc(context.read<AccountsRepository>()),
            child: ManageAccountScreen(
              account: account,
            ),
          );
        });
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text("No route found."),
              ),
              body: Center(child: Text("No route found.")),
            ));
  }
}
