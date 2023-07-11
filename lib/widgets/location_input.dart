import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:flutter_complete_guide/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: lat, longitude: lng);
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    _showPreview(
      locData.latitude as double,
      locData.longitude as double,
    );
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => const MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    _showPreview(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location')),
            ElevatedButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select on map'))
          ],
        )
      ],
    );
  }
}
