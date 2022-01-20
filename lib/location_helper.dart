import 'package:location/location.dart';
import 'dart:io';

class LocationHelper {
  double? _latitude;
  double? _longitude;

  Future<double> getLatitude() async {
    if (_latitude == null) {
      await _lookupLatitudeAndLongitude();
    }
    return _latitude!;
  }

  Future<double> getLongitude() async {
    if (_longitude == null) {
      await _lookupLatitudeAndLongitude();
    }
    return _longitude!;
  }

  Future<void> _lookupLatitudeAndLongitude() async {
    Location location = Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        stderr
            .writeln('WARNING: Stylophile could not enable location services.');
        throw Exception();
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        stderr.writeln(
            'WARNING: Stylophile is not given permissions for location services.');
        throw Exception();
      }
    }

    try {
      LocationData _locationData = await location.getLocation();

      _latitude = _locationData.latitude;
      _longitude = _locationData.longitude;
    } catch (e) {
      stderr
          .writeln('WARNING: Stylophile is not able to find current location.');
      throw Exception();
    }
  }
}
