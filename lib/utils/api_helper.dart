import 'package:flutter/foundation.dart';

class ApiHelper {
  // Pastikan IP ini sesuai dengan laptop Anda saat ini
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Endpoint API (Data)
  static String apiUrl(String path) {
    if (path.startsWith('/')) path = path.substring(1);
    return '$baseUrl/api/$path';
  }

  // Endpoint Gambar (Storage)
  static String? resolveImageUrl(String? url) {
    if (url == null || url.isEmpty) return null;

    // 1. Jika sudah ada http (link luar), pakai langsung
    if (url.startsWith('http')) return url;

    // 2. Bersihkan path
    String cleanPath = url;
    
    // Hapus slash di depan
    if (cleanPath.startsWith('/')) cleanPath = cleanPath.substring(1);

    // [PENTING] Hapus kata 'public/' jika ada di depan. 
    // Karena di Laravel, 'storage/' di URL itu mapping ke folder 'public' di server.
    if (cleanPath.startsWith('public/')) {
      cleanPath = cleanPath.replaceAll('public/', '');
    }

    // Print ke Terminal (Debug) supaya kita tahu link apa yang sedang dicoba
    String finalUrl = '$baseUrl/storage/$cleanPath';
    print("Mencoba Load Gambar: $finalUrl"); 

    return finalUrl;
  }
}