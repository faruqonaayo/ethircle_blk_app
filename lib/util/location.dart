import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> locationAddress(double lat, double long) async {
  final url = Uri.parse(
    "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$long",
  );

  final response = await http.get(
    url,
    headers: {"User-Agent": 'ethircle_vlk_app/1.0 (your_email@example.com)'},
  );

  if (response.statusCode == 200) {
    final result = json.decode(response.body);
    return result["display_name"];
  } else {
    return null;
  }
}
