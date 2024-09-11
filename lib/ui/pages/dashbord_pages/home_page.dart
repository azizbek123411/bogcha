import 'dart:convert';

import 'package:bogcha/repository/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List items = [];

  Future<void> getResponse() async {
    final response = await ApiService.getResponse();

    if (response != null && response is List) {
      setState(() {
        items = response;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Error Occured',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse("https://bw.net.uz/app/");
    final headers = {
      'Authorization': 'f8aa7725fe5dba99dbace20daf85899115391e9d'
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    getResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Yuklanish belgisi
          } else if (snapshot.hasError) {
            return Center(child: Text("Xato: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return Center(
              child: Text("Status: ${data['status']}"),
            );
          } else {
            return Center(child: Text("Ma'lumot topilmadi"));
          }
        },
      ),
    );
  }
}
