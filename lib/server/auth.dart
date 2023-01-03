import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  bool isLogedIn = false;
  String? _token;

  void storeToken({String? token}) {}

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) return _token;
    return null;
  }

  Future<void> LogIn(String? phone, String? password) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/login');
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer',
      };
      dynamic body = {'phone': phone, 'password': password};

      http.Response respon = await http.post(
        url,
        headers: header,
        body: json.encode(body),
      );
      print(json.decode(respon.body));
      print('respon');
      print(respon.statusCode);
      final responData = json.decode(respon.body);
      _token = responData['token'];

      if (respon.statusCode != 200) {
        throw HttpException(
          responData['msg'],
        );
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> SignUp(String? name, String? phone, String? password) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/signup');
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer',
      };
      dynamic body = {'name': name, 'phone': phone, 'password': password};

      http.Response respon = await http.post(
        url,
        headers: header,
        body: json.encode(body),
      );
      print(json.decode(respon.body));
      print('respon');
      print(respon.statusCode);
      final responData = json.decode(respon.body);
      _token = responData['token'];
      if (respon.statusCode != 200) {
        throw HttpException(
          responData['msg'],
        );
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
