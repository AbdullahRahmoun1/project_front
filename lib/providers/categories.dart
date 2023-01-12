import 'package:flutter/material.dart';
import './category.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
      name: 'hi',
      id: '1',
      color: Colors.green,
      icon: Icon(
        Icons.medical_services,
        color: Colors.white,
        size: 35,
      ),
    ),
    Category(
      name: 'hi',
      id: '2',
      color: Colors.orange,
      icon: Icon(
        Icons.workspace_premium,
        color: Colors.white,
        size: 35,
      ),
    ),
    Category(
      name: 'hi',
      id: '3',
      color: Colors.blue,
      icon: Icon(
        Icons.business_center,
        color: Colors.white,
        size: 35,
      ),
    ),
    Category(
      name: 'hi',
      id: '4',
      color: Colors.red,
      icon: Icon(
        Icons.family_restroom,
        color: Colors.white,
        size: 35,
      ),
    ),
    Category(
      name: 'hi',
      id: '5',
      color: Colors.brown,
      icon: Icon(
        Icons.psychology,
        color: Colors.white,
        size: 35,
      ),
    ),
  ];

  // final String? authToken;
  // Categories(this.authToken, this._items);

  List<Category> get items {
    return [..._items];
  }

  void addItem() {
    notifyListeners();
  }
}
