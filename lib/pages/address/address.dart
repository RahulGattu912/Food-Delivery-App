import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  String _locationMessage = "Use My Current Location";
  List<String> searchResults = []; // List to store search results

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Address',
                    style: theme.headlineSmall,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your address',
                    hintStyle: theme.displaySmall
                        ?.copyWith(color: const Color(0xFF767676)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF767676),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFEBEBEB),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFFC0C0C0), width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorTheme.primaryColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _getCurrentLocation, // Trigger location fetching
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/icons/location.svg',
                        colorFilter: ColorFilter.mode(
                          colorTheme.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          _locationMessage, // Update with fetched address
                          style: theme.titleMedium
                              ?.copyWith(color: colorTheme.primaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: colorTheme.indicatorColor,
                ),
              ),
              // Display search results
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(
                        searchResults[index],
                        style: theme.bodyLarge,
                      ),
                      onTap: () {
                        // Handle search result tap if needed
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to fetch current location and convert it to an address
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permission denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            "Location permissions are permanently denied, we cannot request permissions.";
      });
      return;
    }

    // Use LocationSettings instead of deprecated desiredAccuracy
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Can adjust accuracy if needed
        distanceFilter:
            100, // Optional, defines the distance before location is updated
      ),
    );

    // Reverse geocoding to get address from latitude and longitude
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _locationMessage =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        // Add location to search results
        searchResults.add(_locationMessage);
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Could not fetch the address.";
      });
    }
  }
}
