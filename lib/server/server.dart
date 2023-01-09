import 'package:consulting_app/server/auth.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'package:flutter/cupertino.dart';

class Server with ChangeNotifier {
  final String baseUrl = '10.0.2.2';

  String? _getToken(context) {
    return Provider.of<Auth>(context, listen: false).token;
  }

  Future<void> FetchCategory(items, context) async {
    try {
      final url = Uri.parse('http://$baseUrl:8000/api/home');
      var token = _getToken(context);
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: header);
      final extractData =
          json.decode(response.body) as LinkedHashMap<String, dynamic>;
      for (var i = 0; i < items.length; i++) {
        items[i].name = extractData['data']['Specialities'][i]['specialtyName'];
      }
      print(response.statusCode);
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getUserData(int? id, context) async {
    final url = Uri.parse('http://$baseUrl:8000/api/user/-1');
    var token = _getToken(context);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: header);
    final extraxtData1 = json.decode(response.body) as Map<String, dynamic>;
    dynamic extraxtData = Map<String, dynamic>;
    print(extraxtData1);
    print(extraxtData1['data']['phone']);
    return {
      'name': extraxtData1['data']['name'],
      'phone': extraxtData1['data']['phone'],
      'isExp': extraxtData1['data']['isExp']
    };
  }

  Future<void> becomeExpert(
      Map<String?, dynamic> body, BuildContext context) async {
    var token = _getToken(context);
    var url = Uri.parse('http://$baseUrl:8000/api/expert');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      print(json.encode(body));
      final response =
          await http.post(url, headers: header, body: json.encode(body));
      print(response.body);
      print(response.statusCode);
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }
}
