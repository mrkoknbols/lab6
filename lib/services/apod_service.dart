import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apod_model.dart';

class APODService {
  static const String _apiKey = 'wifU4SawytO3uZuoYBlRkF6PVw8irNvpUMJTDzZd'; // Можно заменить на ваш ключ
  static const String _baseUrl = 'https://api.nasa.gov/planetary/apod';

  static Future<APODModel> fetchAPOD({String? date}) async {
    String url = '$_baseUrl?api_key=$_apiKey';
    if (date != null && date.isNotEmpty) {
      url += '&date=$date';
    }

    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return APODModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load APOD: ${response.statusCode}');
    }
  }
}