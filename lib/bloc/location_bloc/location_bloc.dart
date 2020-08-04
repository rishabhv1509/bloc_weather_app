import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/services/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());
  LocationService _locationService = LocationService();
  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    LocationState currentState = state;
    if (event is FetchLocation) {
      try {
        if (currentState is LocationInitial) {
          yield LocationLoading();
          if (_locationService.serviceEnabled &&
              _locationService.permissionGranted == PermissionStatus.granted) {
            await _locationService.getLocation();
            yield LocationFetched(location: _locationService.locationData);
          } else {
            yield LocationError();
          }
        }
      } catch (e) {
        LocationError();
      }
    }
  }
}
