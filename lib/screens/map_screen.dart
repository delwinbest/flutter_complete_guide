import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen(
      {super.key,
      this.initialLocation =
          const PlaceLocation(latitude: 37.411, longitude: -122.084),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Map')),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 16,
              target: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude))),
    );
  }
}
