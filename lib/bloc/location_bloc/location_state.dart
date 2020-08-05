part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationFetchInProgress extends LocationState {}

class LocationFetchSuccess extends LocationState {
  final LocationData location;

  LocationFetchSuccess({this.location});
  LocationFetchSuccess copyWith() {
    return LocationFetchSuccess(location: location ?? this.location);
  }
}

class LocationFetchFailure extends LocationState {}
