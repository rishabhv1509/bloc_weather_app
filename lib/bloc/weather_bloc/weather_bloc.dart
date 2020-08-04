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
    if (event is GetWeatherForecast) {
      try {
        if (currentState is WeatherInitial) {
          var q = await ApiServices().getCurrentLocationWeatherForecast(
              event.location.latitude, event.location.longitude);
          print('q in bloc====>$q');
          final weather = WeatherForecast.fromJson(q);
          print('weather=====>$weather');
          yield WeatherFetched(weather: WeatherForecast.fromJson(q));
        }
      } catch (e) {
        print('error===>$e');
        yield WeatherError();
      }
    }
  }
}
