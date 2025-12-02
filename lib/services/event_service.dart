import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  static Future<List<EventModel>> getEvents() async {
    final response = await http.get(Uri.parse("$baseUrl/events"));

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }
}
