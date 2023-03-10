import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'server.dart';

class Auth with ChangeNotifier {
  bool isLogedIn = false;
  static String? _token;

  void storeToken({String? token}) {}

  bool get isAuth {
    // final storage = new FlutterSecureStorage();
    // var check = storage.read(key: 'token');
    return token != null;
  }

  static String? get token {
    if (_token != null) return _token;
    return null;
  }

  void logout() {
    _token = null;
    notifyListeners();
  }

  Future<void> LogIn(String? phone, String? password) async {
    try {
      final url = Uri.parse('http://$baseUrl:8000/api/login');
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
      print('response');
      print(respon.statusCode);
      final responData = json.decode(respon.body);
      _token = responData['data'];
      if (respon.statusCode != 200) {
        throw HttpException(
          responData['message'],
        );
      }

      final storage = new FlutterSecureStorage();
      if(await storage.containsKey(key: 'token')){
        await storage.delete(key: 'token');
      }
      await storage.write(key: 'token', value: _token);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> SignUp(String? name, String? phone, String? password) async {
    try {
      final url = Uri.parse('http://$baseUrl:8000/api/signup');
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
      _token = responData['data'];
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'token', value: _token);
      if (respon.statusCode != 200) {
        throw HttpException(
          responData['message'],
        );
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
