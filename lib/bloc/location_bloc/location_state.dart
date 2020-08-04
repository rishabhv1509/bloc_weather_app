part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationFetched extends LocationState {
  final LocationData location;

  LocationFetched({this.location});
  LocationFetched copyWith() {
    return LocationFetched(location: location ?? this.location);
  }
}

class LocationError extends LocationState {}
