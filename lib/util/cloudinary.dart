import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:http/http.dart' as http;

final cloudinaryObj = Cloudinary.fromCloudName(cloudName: "du7eu4jhl");

void uploadToCloudinary(File file) async {
  final url = Uri.parse("https://api.cloudinary.com/v1_1/du7eu4jhl/upload");

  final request = http.MultipartRequest("POST", url);

  request.fields["upload_preset"] = "maablk";

  final fileToUpload = await http.MultipartFile.fromPath("file", file.path);
  request.files.add(fileToUpload);

  final response = await request.send();

  if (response.statusCode == 200) {
    // convert the response to readable map
    final responseStr = await response.stream.bytesToString();

    final result = jsonDecode(responseStr);
  }
}
