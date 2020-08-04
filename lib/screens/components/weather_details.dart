import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/services/size_config.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherForecast weather;

  WeatherDetails({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(weather.current.lastUpdated.toString());
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            '${weather.location.name}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.toFont,
            ),
          ),
        ),
        SizedBox(height: 5.toHeight),
        Center(
          child: Text(
            'Updated at ${dateTime.hour}:${dateTime.minute}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.toFont,
            ),
          ),
        ),
        SizedBox(height: 50.toHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              weather.current.tempC.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.toFont,
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'min ${weather.forecast.forecastday[0].day.mintempC.toString()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.toFont,
                  ),
                ),
                Text(
                  'max ${weather.forecast.forecastday[0].day.maxtempC.toString()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.toFont,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 80.toHeight,
        ),
        Container(
          height: 30.toHeight,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.forecast.forecastday.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text(weather.forecast.forecastday[index].date),
                );
              }),
        )
      ],
    );
  }
}
