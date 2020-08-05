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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Center(
          child: Text(
            '${weather.location.name}',
            textAlign: TextAlign.center,
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
            Image.network(
              'https:${weather.current.condition.icon}',
              width: 40,
              height: 40,
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
        Text(
          '3 Days Forecast',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.toFont,
          ),
        ),
        Container(
          height: 200.toHeight,
          child: ListView.separated(
            itemCount: weather.forecast.forecastday.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 10.toWidth,
            ),
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DateTime date =
                  DateTime.parse(weather.forecast.forecastday[index].date);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('${date.day} /${date.month}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.toFont,
                      )),
                  Text(
                    'Max: ${weather.forecast.forecastday[index].day.maxtempC}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.toFont,
                    ),
                  ),
                  Text(
                    'Min: ${weather.forecast.forecastday[index].day.mintempC}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.toFont,
                    ),
                  ),
                  Container(
                    width: 120,
                    child: Text(
                      '${weather.forecast.forecastday[index].day.condition.text}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 15.toFont,
                      ),
                    ),
                  ),
                  Image.network(
                    'https:${weather.forecast.forecastday[index].day.condition.icon}',
                    width: 40,
                    height: 40,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
