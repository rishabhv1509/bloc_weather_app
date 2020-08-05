part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherFetchInProgress extends WeatherState {}

class WeatherFetchFailure extends WeatherState {}

class WeatherFetchSuccess extends WeatherState {
  final WeatherForecast weather;

  WeatherFetchSuccess({this.weather});
  WeatherFetchSuccess copyWith() {
    return WeatherFetchSuccess(
      weather: weather ?? this.weather,
    );
  }
}
