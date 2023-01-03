import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Category with ChangeNotifier {
  String? name;
  Color color;
  Icon icon;

  Category({required this.name, required this.color, required this.icon});
}
