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
  LatLng? _pickedLocation;
  void selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
          onTap: widget.isSelecting ? selectLocation : null,
          markers: _pickedLocation == null
              ? ({})
              : {
                  Marker(
                      markerId: const MarkerId('m1'),
                      position: _pickedLocation as LatLng)
                },
          initialCameraPosition: CameraPosition(
              zoom: 16,
              target: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude))),
    );
  }
}
