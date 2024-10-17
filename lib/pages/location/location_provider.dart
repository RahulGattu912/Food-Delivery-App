import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String _location = '';

  String get location => _location;

  Future<bool> getLocationMessage(String addressName, String uid) async {
    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      // Reverse geocode to get address
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];

      _location =
          "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";

      notifyListeners(); // Notify listeners of the change
      return true; // Indicate success
    } catch (e) {
      // Handle exceptions here (e.g., log the error)
      return false; // Indicate failure
    }
  }
}
