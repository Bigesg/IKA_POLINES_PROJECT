import 'package:flutter/foundation.dart';

class ApiHelper {
  // GANTI SESUAI KONDISI
  static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String storageUrl = "http://127.0.0.1:8000/storage";

  static String apiUrl(String endpoint) {
    return "$baseUrl/$endpoint";
  }

  /// 🔥 FIX IMAGE URL (LOCALHOST SOLVER)
  static String resolveImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";

    // kalau sudah full URL, langsung pakai
    if (path.startsWith("http")) return path;

    // kalau cuma nama file / folder
    return "$storageUrl/$path";
  }
}
