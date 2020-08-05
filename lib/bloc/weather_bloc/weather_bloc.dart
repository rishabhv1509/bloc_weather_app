import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/services/api_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    WeatherState currentState = state;
    if (event is WeatherFetchedByLocation) {
      try {
        if (currentState is WeatherInitial) {
          var weatherResponse = await ApiServices()
              .getCurrentLocationWeatherForecast(
                  event.location.latitude, event.location.longitude);
          print('weatherResponse in bloc====>$weatherResponse');
          final weather = WeatherForecast.fromJson(weatherResponse);
          yield WeatherFetchSuccess(weather: weather);
        }
      } catch (e) {
        print('error===>$e');
        yield WeatherFetchFailure();
      }
    } else if (event is WeatherFetchedByCity) {
      try {
        if (currentState is WeatherFetchSuccess ||
            currentState is WeatherInitial ||
            currentState is WeatherFetchFailure) {
          yield WeatherFetchInProgress();
          var weatherResponse =
              await ApiServices().getCityWeatherForecast(event.city);
          print('weatherResponse in bloc====>$weatherResponse');
          // try {
          if (weatherResponse == null) {
            yield WeatherFetchFailure();
          } else {
            final weather = WeatherForecast.fromJson(weatherResponse);
            print('weather=====>$weather');
            yield WeatherFetchSuccess(
                weather: WeatherForecast.fromJson(weatherResponse));
          }
          // } catch (e) {
          //   yield WeatherFetchFailure();
          // }
        }
      } catch (e) {
        yield WeatherFetchFailure();
      }
    }
  }
}
