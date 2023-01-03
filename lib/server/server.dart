import 'dart:convert';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Server {
  String? token;

  Future<Map> singIn(String phone, String password) async {
    final result = {};
    try {
      final url = Uri.parse('uri');
      final response = await http.post(url,
          headers: {'accept': 'application/json', 'authorization': ''},
          body: json.encode({'phone': phone, 'password': password}));
      var body = json.decode(response.body);
      if (response.statusCode == 404) {
        var msg = body['msg'];
      }
      //error
    } catch (error) {
      print(error);
    }
    return result;
  }
}
