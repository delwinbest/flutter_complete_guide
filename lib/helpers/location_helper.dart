import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "XXX";

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final response = await http.get(Uri.https(
        "maps.googleapis.com",
        "/maps/api/geocode/json",
        {'latlng': '$lat,$long', 'key': GOOGLE_API_KEY}));
    // print(json.decode(response.body));
    // print(json.decode(response.body)['results']);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
