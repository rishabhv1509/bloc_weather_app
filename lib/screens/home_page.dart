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
    print('object');
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
          if (state is LocationFetchSuccess) {
            LocationData location = state.location;
            return BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
              context.bloc<WeatherBloc>().add(
                    WeatherFetchedByLocation(location: location),
                  );
              if (state is WeatherFetchSuccess) {
                return WeatherDetails(weather: state.weather);
              } else if (state is WeatherFetchFailure) {
                return Center(
                  child: Text(
                    'Some error occurred in fetching weather',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.toFont,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 10.toHeight),
                      Text(
                        'Fetching Weather',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.toFont,
                        ),
                      )
                    ],
                  ),
                );
              }
            });
          } else if (state is LocationFetchInProgress) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10.toHeight),
                  Text(
                    'Fetching Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.toFont,
                    ),
                  )
                ],
              ),
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
