import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    print('Getting lcoation');
    final locData = await Location().getLocation();
    print(locData.latitude);
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: locData.latitude as double,
          longitude: locData.longitude as double);
    });
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
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('Select on map'))
          ],
        )
      ],
    );
  }
}
