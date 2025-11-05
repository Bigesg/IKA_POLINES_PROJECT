import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class AuthService {
  // Base URL otomatis sesuai platform
  static String get baseUrl {
    const ipLaptop = "172.20.10.4";

    if (kIsWeb) {
      // Flutter Web → pakai IP laptop
      return "http://$ipLaptop:8000/api";
    } else if (Platform.isAndroid) {
      // Android Emulator → 10.0.2.2 mengarah ke localhost
      return "http://10.0.2.2:8000/api";
    } else if (Platform.isIOS) {
      // iOS simulator → localhost bisa langsung diakses
      return "http://localhost:8000/api";
    } else {
      // fallback
      return "http://$ipLaptop:8000/api";
    }
  }

  /// 🔹 Register user baru
  /// Mengembalikan Map dengan key 'success' dan 'message'
  Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String password,
    required String jurusan,
    required String prodi,
    required String tahunLulus,
    required String nomorKTA,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama_alumni': nama,
          'email': email,
          'password': password,
          'jurusan_alumni': jurusan,
          'prodi_alumni': prodi,
          'tahun_lulus': tahunLulus,
          'nomor_kta': nomorKTA,
        }),
      );

      // Jika status 200 atau 201, kembalikan JSON response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Gagal register. Status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      // Error koneksi atau fetch
      return {
        'success': false,
        'message': 'Error koneksi ke server: $e',
      };
    }
  }

  /// 🔹 Login user
  /// Contoh tambahan jika nanti dibutuhkan
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Gagal login. Status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error koneksi ke server: $e',
      };
    }
  }
}
