import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String?> getPriceEstimate(String start, String end) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'start': start,
        'end': end,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['estimate'];
    } else {
      throw Exception('Failed to load price estimate');
    }
  }
}
