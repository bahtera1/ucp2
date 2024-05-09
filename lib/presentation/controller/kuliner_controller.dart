import 'dart:convert';
import 'dart:io';

import 'package:ucp2/data/service/kuliner_service.dart';
import 'package:ucp2/domain/model/kuliner_model.dart';

class KulinerController {
  final kulinerService = KulinerService();

  Future<Map<String, dynamic>> addKuliner(Kuliner person, File? file) async {
    Map<String, String> data = {
      'nama': person.namakuliner,
      'notelepon': person.notelepon,
      'alamat': person.alamat,
      'harga': person.harga
    };

    try {
      var response = await kulinerService.addKuliner(data, file);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data berhasil disimpan',
        };
      } else {
        // Penanganan ketika Content-Type bukan application/json
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }
        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data',
        };
      }
    } catch (e) {
      // Menangkap kesalahan jaringan atau saat decoding JSON
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<List<Kuliner>> getKuliner() async {
    try {
      List<dynamic> kulinerData = await kulinerService.fetchPeople();
      if (kulinerData != null) {
        List<Kuliner> people =
            kulinerData.map((json) => Kuliner.fromMap(json)).toList();
        return people;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get people: $e');
    }
  }
  // Future<List<Kuliner>> getKuliner() async {
  //   try {
  //     List<dynamic> kulinerData = await kulinerService.fetchPeople();
  //     List<Kuliner> people =
  //         kulinerData.map((json) => Kuliner.fromMap(json)).toList();
  //     return people;
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception('Failed to get people: $e');
  //   }
  // }
}
