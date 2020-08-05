import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/screens/splash.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LocationBloc>(
      create: (context) {
        return LocationBloc()..add(LocationFetched());
      },
    ),
    BlocProvider<WeatherBloc>(
      create: (context) {
        return WeatherBloc();
      },
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
