import 'package:location/location.dart';

class LocationService {
  LocationService._();
  static LocationService _instance = LocationService._();
  factory LocationService() => _instance;
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;
  getPermission() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  getLocation() async {
    location.changeSettings(accuracy: LocationAccuracy.high);
    locationData = await location.getLocation();
    return locationData;
  }
}
