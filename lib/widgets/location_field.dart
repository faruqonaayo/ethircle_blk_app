import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:ethircle_blk_app/models/place_location.dart';
import 'package:ethircle_blk_app/util/location.dart';
import 'package:ethircle_blk_app/screens/map_screen.dart';

class LocationField extends StatefulWidget {
  const LocationField({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationField> createState() {
    return _LocationFieldState();
  }
}

class _LocationFieldState extends State<LocationField> {
  String? _address;
  double? _latitude;
  double? _longitude;
  var _isFetching = false;

  void _currentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    setState(() {
      _isFetching = true;
    });

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

    locationData = await location.getLocation();

    setState(() {
      _isFetching = false;
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
    });

    final addressResult = await locationAddress(_latitude!, _longitude!);

    setState(() {
      _address = addressResult;
    });

    widget.onSelectLocation(
      PlaceLocation(lat: _latitude!, long: _longitude!, address: _address),
    );
  }

  void _openMap(BuildContext context) async {
    final result = await Navigator.of(context).push<PlaceLocation?>(
      MaterialPageRoute(
        builder: (ctx) {
          if (_latitude == null || _longitude == null) {
            return MapScreen();
          }

          return MapScreen(
            location: PlaceLocation(
              lat: _latitude!,
              long: _longitude!,
              address: _address,
            ),
          );
        },
      ),
    );

    // checking out the result of updating the map
    if (result != null) {
      setState(() {
        _latitude = result.lat;
        _longitude = result.long;
        _address = result.address;
      });
      widget.onSelectLocation(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: colorScheme.primary),
      ),
      child: Column(
        children: [
          Text(
            "Location Suggestion",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            _address == null ? "No Address" : _address!,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Latitude: $_latitude, Longitude: $_longitude",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              ElevatedButton.icon(
                onPressed: _isFetching ? null : _currentLocation,
                label: Text("Current Location"),
                icon: _isFetching
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(Icons.location_pin),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              TextButton.icon(
                onPressed: _isFetching
                    ? null
                    : () {
                        _openMap(context);
                      },
                label: Text("Map"),
                icon: Icon(Icons.map),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
