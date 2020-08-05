import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/services/size_config.dart';
import 'package:intl/intl.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherForecast weather;
  final Color textColor;

  WeatherDetails({Key key, this.weather, @required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(weather.current.lastUpdated.toString());
    String formattedDate = DateFormat.MMMMEEEEd('en_US').format(dateTime);
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            '${weather.location.name}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 40.toFont,
            ),
          ),
        ),
        SizedBox(height: 10.toHeight),
        Center(
          child: Text(
            formattedDate,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.toFont,
            ),
          ),
        ),
        SizedBox(height: 50.toHeight),
        Text(
          '${weather.current.tempC.toString()}° C',
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 70.toFont,
              fontFamily: 'Neuro'),
        ),
        SizedBox(height: 20.toHeight),
        Container(
          height: 2,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 5.toHeight),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (context, index) => Container(
              width: 12,
              color: textColor,
            ),
          ),
        ),
        SizedBox(height: 35.toHeight),
        Center(
          child: Text(
            weather.current.condition.text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.toFont,
            ),
          ),
        ),
        SizedBox(height: 15.toHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${weather.forecast.forecastday[0].day.mintempC.toString()}° C / ${weather.forecast.forecastday[0].day.maxtempC.toString()} ° C',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.toFont,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 140.toHeight,
        ),
        Container(
          height: 100.toHeight,
          child: ListView.separated(
            itemCount: weather.forecast.forecastday.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 10.toWidth,
            ),
            // padding: EdgeInsets.all(20),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    'https:${weather.forecast.forecastday[index].day.condition.icon}',
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    '${weather.forecast.forecastday[index].day.maxtempC}° C / ${weather.forecast.forecastday[index].day.mintempC}° C',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.toFont,
                    ),
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
