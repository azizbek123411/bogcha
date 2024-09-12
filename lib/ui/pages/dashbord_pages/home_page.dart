import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class HomePages extends StatefulWidget {
  static const String id = 'home';

  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  var box = Hive.box('token');

  Future<Map<String, dynamic>> fetchData() async {
    final url = Uri.parse("https://bw.net.uz/app/");
    final headers = {
      'Authorization': 'Token ${box.get(1)}',
      'Content-Type': "application/json"
    };
    try {
      final response = await http.get(url, headers: headers);
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, st) {
      log(
        'Error: ',
        error: e,
        stackTrace: st,
      );
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            log(snapshot.stackTrace.toString());
            log(box.get(1));
            return Center(
              child: Text("Xato: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            log(box.get(1));
            final data = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      title: Text(
                        data['info']['username'],
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(data['info']['type_display']),
                      trailing: Text(data['info']['company'] ?? "Unknown"),
                    ));
          } else {
            return const Center(child: Text("Ma'lumot topilmadi"));
          }
        },
      ),
    );
  }
}
