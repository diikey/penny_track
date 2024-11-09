import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/utils/cache.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  late Cache _cache;

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    if (_cache.getString(key: Cache.cacheToken) != "") {
      Navigator.pushReplacementNamed(context, Routes.appRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  @override
  void initState() {
    _cache = context.read<Cache>();
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Text(
          "Penny Track",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
