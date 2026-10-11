import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

Future<String?> uploadImageToImgBB(PlatformFile imageFile) async {
  String apiKey = "7dc3ca4cf9b79c29d6507b504eded8b5";
  final uri = Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey");

  final request = http.MultipartRequest('POST', uri)
    ..files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageFile.bytes!,
        filename: imageFile.name,
      ),
    );

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();
  final apiResult = json.decode(responseBody);

  if (response.statusCode == 200 && apiResult['success'] == true) {
    return apiResult['data']['url'];
  } else {
    return null;
  }
}
