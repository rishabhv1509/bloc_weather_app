import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/screens/components/weather_details.dart';
import 'package:weather_app/screens/search_page.dart';
import 'package:weather_app/services/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff324098),
      appBar: AppBar(
        title: Text('Weather App'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              })
        ],
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationFetched) {
            LocationData location = state.location;
            return BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              context.bloc<WeatherBloc>().add(
                    GetWeatherForecast(location: location),
                  );
              if (state is WeatherFetched) {
                return WeatherDetails(weather: state.weather);
              } else {
                return Container(
                  color: Colors.green,
                );
              }
            });
          } else if (state is LocationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text(
                'Unable to fetch location, please use the search button above',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.toFont,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
