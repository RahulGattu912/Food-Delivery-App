import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkLocationServicesEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<bool> checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  // Modify the function to accept an addressName
  Future<String> getLocationMessage(String addressName, String uid) async {
    String locationMessage = "";

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    // Get current location
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    // Reverse geocode to get address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];

    locationMessage =
        "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";

    // Store the address in Firestore for the specific user
    await _storeLocationInFirestore(uid, addressName, locationMessage);

    return locationMessage;
  }

  // Update Firestore method to include user ID and address name
  Future<void> _storeLocationInFirestore(
      String uid, String addressName, String address) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .add({
        'name': addressName, // Name of the address (e.g., Home, Work)
        'address': address,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Failed to add location to Firestore: $e");
    }
  }
}


// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LocationService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<bool> checkLocationServicesEnabled() async {
//     // Check if location services are enabled
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     return serviceEnabled;
//   }

//   Future<void> openLocationSettings() async {
//     await Geolocator.openLocationSettings();
//   }

//   Future<bool> checkLocationPermissions() async {
//     // Check for location permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     return permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always;
//   }

//   Future<String> getLocationMessage() async {
//     String locationMessage = "";

//     // Define location settings
//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10, // Minimum distance (in meters) for location updates
//     );

//     // Get current location
//     Position position =
//         await Geolocator.getCurrentPosition(locationSettings: locationSettings);

//     // Reverse geocode to get address
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     Placemark placemark = placemarks[0];

//     locationMessage =
//         "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";

//     // Store address in Firestore
//     await _storeLocationInFirestore(locationMessage);

//     return locationMessage;
//   }

//   Future<void> _storeLocationInFirestore(String address) async {
//     try {
//       await _firestore.collection('locations').add({
//         'address': address,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print("Failed to add location to Firestore: $e");
//     }
//   }
// }
