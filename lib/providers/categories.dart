import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import './category.dart';
import '../server/auth.dart';
import 'package:http/http.dart' as http;

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
      id: 1,
      color: Colors.green,
      icon: Icon(
        Icons.medical_services,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      id: 2,
      color: Colors.orange,
      icon: Icon(
        Icons.workspace_premium,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      id: 3,
      color: Colors.blue,
      icon: Icon(
        Icons.business_center,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      id: 4,
      color: Colors.red,
      icon: Icon(
        Icons.family_restroom,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      id: 5,
      color: Colors.brown,
      icon: Icon(
        Icons.psychology,
        color: Colors.white,
        size: 45,
      ),
    ),
  ];

  final String? authToken;
  Categories(this.authToken, this._items);

  Future<void> FetchCategory(String? token) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/api/home');
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: header);
      final extractData = json.decode(response.body) as Map<String?, dynamic>;
      for (var i = 0; i < items.length; i++) {
        items[i].name = extractData['Specialities'][i]['specialtyName'];
      }
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  List<Category> get items {
    return [..._items];
  }

  void addItem() {
    notifyListeners();
  }
}
