import 'package:flutter/material.dart';
import './category.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
      name: Text(
        'Bussnis',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Colors.blue,
      icon: Icon(
        Icons.business_center,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: Text(
        'Family',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Colors.red,
      icon: Icon(
        Icons.family_restroom,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: Text(
        'psychology',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Colors.brown,
      icon: Icon(
        Icons.psychology,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: Text(
        'Medical',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Colors.green,
      icon: Icon(
        Icons.medical_services,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: Text(
        'Professional',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      color: Colors.orange,
      icon: Icon(
        Icons.workspace_premium,
        color: Colors.white,
        size: 45,
      ),
    )
  ];

  List<Category> get items {
    return [..._items];
  }

  void addItem() {
    notifyListeners();
  }
}
