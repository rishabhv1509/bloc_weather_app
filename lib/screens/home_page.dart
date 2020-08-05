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
  String bg = 'assets/default.jpg';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherFetchSuccess) {
        if (state.weather.current.condition.text.contains('rain')) {
          bg = 'assets/rainy.jpg';
        } else if (state.weather.current.condition.text.contains('Sunny')) {
          bg = 'assets/sunny.jpg';
        } else if (state.weather.current.condition.text.contains('cloudy')) {
          bg = 'assets/snowy.jpg';
        } else {
          bg = 'assets/default.jpg';
        }
      } else if (state is WeatherFetchFailure) {
        bg = 'assets/default.jpg';
      }
      return Stack(
        children: <Widget>[
          Image.asset(
            bg,
            width: SizeConfig().screenWidth,
            height: SizeConfig().screenHeight,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0, backgroundColor: Colors.transparent,
              // title: Text('Weather App'),
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
                      return WeatherDetails(
                        weather: state.weather,
                        textColor: (bg == 'assets/sunny.jpg')
                            ? Color(0xffF8C346)
                            : (bg == 'assets/rainy.jpg')
                                ? Color(0xff540b0e)
                                : Color(0xfffff3b0),
                      );
                    } else if (state is WeatherFetchFailure) {
                      return Text(
                        'Some error occurred in fetching weather',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffe71d36),
                            fontSize: 30.toFont,
                            fontWeight: FontWeight.bold),
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
                                  color: Color(0xffe71d36),
                                  fontSize: 30.toFont,
                                  fontWeight: FontWeight.bold),
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
                              color: Color(0xffe71d36),
                              fontSize: 30.toFont,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                } else {
                  return Text(
                    'Unable to fetch location, please use the search button above',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.toFont,
                        color: Color(0xffe71d36),
                        fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
