import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testflutter/models/movie_factory.dart';
import 'package:testflutter/models/movie_model.dart';
import '../config.dart';

class ApiService {
  static Future<List<MovieModel>> fetchMovies() async {
    final url = Uri.parse('${AppConfig.baseUrl}/whoas/random?results=20');
    print('*****************************************');
    print('[API REQUEST] GET $url');
    final response = await http.get(url);
    print('✅ [API STATUS] ${response.statusCode}');
    print('📝 [API RESPONSE BODY] ${response.body}');
    print('*****************************************');

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return MovieFactory.fromJsonList(data);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
