import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:ethircle_blk_app/models/place_location.dart';
import 'package:ethircle_blk_app/util/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.location});

  final PlaceLocation? location;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  LatLng _currentLocation = LatLng(1.2878, 103.866);
  String? _address;
  var _isFetching = false;

  void _fetchLocationAddress() async {
    setState(() {
      _isFetching = true;
    });

    final result = await locationAddress(
      _currentLocation.latitude,
      _currentLocation.longitude,
    );

    setState(() {
      _address = result;
      _isFetching = false;
    });
  }

  void _updateLocation(BuildContext context) {
    Navigator.of(context).pop(
      PlaceLocation(
        lat: _currentLocation.latitude,
        long: _currentLocation.longitude,
        address: _address,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.location != null) {
      final location = widget.location!;
      _currentLocation = LatLng(location.lat, location.long);
      _address = location.address;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            _address == null ? "No address" : _address!,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.maxFinite,
            height: 640,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: 8,
                minZoom: 5,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
                onTap: _isFetching
                    ? null
                    : (tapPosition, point) async {
                        setState(() {
                          _currentLocation = point;
                        });
                        _fetchLocationAddress();
                      },
              ),

              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation,
                      child: Icon(Icons.location_pin),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _updateLocation(context);
            },
            child: Text("Update Address"),
          ),
        ],
      ),
    );
  }
}
