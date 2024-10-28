import 'package:flutter/material.dart';
import 'package:penny_track/ui/app/app.dart';
import 'package:penny_track/ui/records/manage_record_screen.dart';
import 'package:penny_track/ui/splash/splash_screen.dart';
import 'package:penny_track/data/dto/records/record.dart';

class Routes {
  static const String splashRoute = "/";
  static const String appRoute = "/app";
  static const String manageRecordRoute = "/manage_record";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.appRoute:
        return MaterialPageRoute(builder: (_) => App());
      case Routes.manageRecordRoute:
        final Record? record = routeSettings.arguments as Record?;
        return MaterialPageRoute(
            builder: (_) => ManageRecordScreen(
                  record: record,
                ));
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
