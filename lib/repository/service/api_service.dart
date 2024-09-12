import 'dart:convert';
import 'dart:developer';

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





  // Future<Map<String, dynamic>> fetchData() async {
  //   final url = Uri.parse("https://bw.net.uz/app/");
  //   final headers = {
  //     'Authorization': 'Token 1b7081da747b4b21524823abb18b8e3a2f3c1064',
  //     'Content-Type':"application/json"
  //   };
  //   try {
  //     final response = await http.get(url, headers: headers);
  //     log('Response status: ${response.statusCode}');
  //     log('Response body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e,st) {
  //     log('Error: ',error: e,stackTrace: st,);
  //   } return {};
  // }

  static Future getResponse(String token) async {
    const url = 'https://bw.net.uz/app/';
    final headers = {
      'Authorization': 'Token $token',
      'Content-Type':"application/json"
    };
    final uri = Uri.parse(url);
    final response = await http.get(uri,headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body) as Map<String,dynamic>;
      final result=json['info'] as List<dynamic>;
      print(result);
      return result;

    } else {
      return null;
    }
  }
}
