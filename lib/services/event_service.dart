import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../utils/api_helper.dart';

class EventService {
  static Future<List<EventModel>> getEvents() async {
    final response = await http.get(Uri.parse(ApiHelper.apiUrl('/api/events')));

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }
}
