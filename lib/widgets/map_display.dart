import 'package:ethircle_blk_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDisplay extends StatefulWidget {
  const MapDisplay({super.key, required this.items});

  final List<Item> items;

  @override
  State<MapDisplay> createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    // filtering th list with only items with latitud and longitude
    final items = widget.items
        .where((item) => item.lat != null && item.long != null)
        .toList();

    return SizedBox(
      width: double.maxFinite,
      height: 240,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(48, -113.866),
          initialZoom: 3,
          minZoom: 2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: items
                .map(
                  (item) => Marker(
                    point: LatLng(item.lat!, item.long!),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Latitude: ${item.lat}'),
                                Text('Longitude: ${item.long}'),
                                Text('Address: ${item.address}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(Icons.location_pin),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
