import 'package:flutter/material.dart';
import 'package:penny_track/ui/app/app.dart';
import 'package:penny_track/ui/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String appRoute = "/app";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.appRoute:
        return MaterialPageRoute(builder: (_) => App());
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
