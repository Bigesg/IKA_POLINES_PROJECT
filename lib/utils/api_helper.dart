import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class ApiHelper {
  // ✅ DYNAMIC BASE URL untuk setiap platform
  // KONFIGURASI: Update sesuai IP laptop/server Anda
  static const String _serverHost = "localhost"; // atau IP laptop: "192.168.x.x"
  static const int _serverPort = 8000;
  
  static String get baseUrl {
    if (kIsWeb) {
      return "http://$_serverHost:$_serverPort/api"; // Flutter Web
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:$_serverPort/api"; // Android emulator → localhost laptop
    } else if (Platform.isIOS) {
      return "http://localhost:$_serverPort/api"; // iOS simulator
    } else {
      return "http://$_serverHost:$_serverPort/api"; // Fallback untuk platform lain
    }
  }

  static String get storageUrl {
    if (kIsWeb) {
      return "http://$_serverHost:$_serverPort/storage"; // Flutter Web
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:$_serverPort/storage"; // Android emulator
    } else if (Platform.isIOS) {
      return "http://localhost:$_serverPort/storage"; // iOS simulator
    } else {
      return "http://$_serverHost:$_serverPort/storage"; // Fallback
    }
  }

  static String apiUrl(String endpoint) {
    return "$baseUrl$endpoint";
  }

  /// 🔥 FIX IMAGE URL (PLATFORM-AWARE RESOLVER)
  static String resolveImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";

    // kalau sudah full URL (http/https), langsung pakai
    if (path.startsWith("http")) return path;

    // jika path dimulai dengan /, hapus dulu
    String cleanPath = path.startsWith("/") ? path.substring(1) : path;

    // gabungkan dengan storage URL
    final url = "${storageUrl}/$cleanPath";
    
    // Debug log untuk troubleshooting (hapus jika sudah production)
    // ignore: avoid_print
    print("✅ Resolved image URL: $url");
    
    return url;
  }
}

