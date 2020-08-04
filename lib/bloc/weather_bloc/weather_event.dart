part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherForecast extends WeatherEvent {
  final LocationData location;
  final String city;
  GetWeatherForecast({this.location, this.city});
}
