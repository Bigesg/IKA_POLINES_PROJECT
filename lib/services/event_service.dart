import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  static Future<List<EventModel>> getEvents(String type) async {
    final response = await http.get(Uri.parse("$baseUrl/events?type=$type"));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body)['data'];
      return jsonData.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }
}
