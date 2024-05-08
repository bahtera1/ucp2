import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class KulinerService {
  final String baseUrl = 'https://paml.tatiumy.com/api/';
  final String endpoint = 'people';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addKuliner(Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST',
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
    } else {
      request.files.add(http.MultipartFile.fromString('gambar', ''));
    }

    return await http.Response.fromStream(await request.send());
  }

  Future<List<dynamic>> fetchPeople() async {
    try {
      var response = await http.get(
        getUri(endpoint),
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        return decodedResponse['kuliner'];
      } else {
        throw Exception('Failed to load kuliner: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list instead of null
    }
  }
  // Future<List<dynamic>> fetchPeople() async {
  //   var response = await http.get(
  //     getUri(endpoint),
  //     headers: {
  //       "Accept": "application/json",
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> decodedResponse = json.decode(response.body);
  //     return decodedResponse[
  //         'kuliner']; // Akses array people dari objek response
  //   } else {
  //     throw Exception('Failed to load kuliner: ${response.reasonPhrase}');
  //   }
  // }
}
