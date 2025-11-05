import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

/// 🌐 Service untuk koneksi ke API backend Laravel
class ApiService {
  /// Base URL otomatis sesuai platform (inline ternary)
  static final String baseUrl = kIsWeb
      ? 'http://172.20.10.4:8000/api' // Flutter Web → IP laptop
      : Platform.isAndroid
          ? 'http://10.0.2.2:8000/api' // Android emulator → localhost laptop
          : Platform.isIOS
              ? 'http://localhost:8000/api' // iOS simulator
              : 'http://172.20.10.4:8000/api'; // fallback

  /// 📥 Mendapatkan data alumni
  static Future<List<dynamic>> getAlumni() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/alumni'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal memuat data alumni. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error getAlumni: $e');
      rethrow;
    }
  }

  /// 📤 Menambahkan data alumni baru
  static Future<Map<String, dynamic>> tambahAlumni(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/alumni'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Gagal menambahkan alumni. Status: ${response.statusCode}, Body: ${response.body}',
        };
      }
    } catch (e) {
      print('❌ Exception tambahAlumni: $e');
      return {
        'success': false,
        'message': 'Error koneksi ke server: $e',
      };
    }
  }
}
