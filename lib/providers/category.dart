import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Category with ChangeNotifier {
  String? name;
  int id;
  Color color;
  Icon icon;

  Category(
      {required this.id,
      this.name = 'Siuuuu',
      required this.color,
      required this.icon});
}
