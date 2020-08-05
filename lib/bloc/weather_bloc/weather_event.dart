part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherFetchedByLocation extends WeatherEvent {
  final LocationData location;

  WeatherFetchedByLocation({this.location});
}

class WeatherFetchedByCity extends WeatherEvent {
  final String city;

  WeatherFetchedByCity({this.city});
}
