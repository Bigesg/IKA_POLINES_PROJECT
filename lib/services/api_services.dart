import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api"; // emulator Android
  // kalau pakai HP asli di WiFi sama, ganti 10.0.2.2 dengan IP laptop kamu

  static Future<List<dynamic>> getAlumni() async {
    final response = await http.get(Uri.parse('$baseUrl/alumni'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Gagal memuat data alumni');
    }
  }

  static Future<bool> tambahAlumni(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/alumni'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error: ${response.body}');
      return false;
    }
  }
}
