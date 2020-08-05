import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getLocationPermission();
  }

  getLocationPermission() async {
    Future.delayed(Duration(seconds: 1));
    await LocationService().getPermission();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(
        child: Container(
          height: 240.toHeight,
          width: 240.toWidth,
          child: Hero(
            tag: 'hero',
            child: Image.asset('assets/splash.jpg'),
          ),
        ),
      ),
    );
  }
}
