import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> signUp(String login, String password) async {
    final body = {
      'username': login,
      'password': password,
    };
    const url = 'https://bw.net.uz/app/login/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<List?> getResponse() async {
    const url = 'https://bw.net.uz/app/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if(json is List){
        return json;
      }else{
        return null;
      }
    } else {
      return null;
    }
  }
}
