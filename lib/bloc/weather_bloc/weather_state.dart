part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class LoadingWeather extends WeatherState {}

class WeatherError extends WeatherState {}

class WeatherFetched extends WeatherState {
  final WeatherForecast weather;

  WeatherFetched({this.weather});
  WeatherFetched copyWith() {
    return WeatherFetched(
      weather: weather ?? this.weather,
    );
  }
}
