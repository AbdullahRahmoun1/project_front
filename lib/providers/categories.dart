import 'package:flutter/material.dart';
import './category.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
      name: 'Bussnis',
      color: Colors.blue,
      icon: Icon(
        Icons.business_center,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: 'Family',
      color: Colors.red,
      icon: Icon(
        Icons.family_restroom,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: 'psychology',
      color: Colors.brown,
      icon: Icon(
        Icons.psychology,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: 'Medical',
      color: Colors.green,
      icon: Icon(
        Icons.medical_services,
        color: Colors.white,
        size: 45,
      ),
    ),
    Category(
      name: 'Professional',
      color: Colors.orange,
      icon: Icon(
        Icons.workspace_premium,
        color: Colors.white,
        size: 45,
      ),
    )
  ];

  // Text(
  //       'Professional',
  //       style: TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //     )

  List<Category> get items {
    return [..._items];
  }

  void addItem() {
    notifyListeners();
  }
}
