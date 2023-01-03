import 'package:flutter/cupertino.dart';

import '../modles/specialize.dart';
import 'package:provider/provider.dart';

class User with ChangeNotifier {
  String? id;
  String? name;
  String? imagePath;
  List<String> category;
  List<String> spForSearch;
  List<Specialize> specialize;
  bool isExpert;
  bool canEdit;
  bool isFavorit;
  double? rate;

  User(
      {required this.id,
      required this.name,
      this.imagePath = 'assets/images/user.png',
      this.category = const [],
      this.specialize = const [],
      this.spForSearch = const [],
      this.isExpert = false,
      this.canEdit = false,
      this.isFavorit = false,
      this.rate = 0});

  void toggleFavoritStatus() {
    isFavorit = !isFavorit;
    notifyListeners();
  }

  void changRate(double newRate) {
    rate = newRate;
    notifyListeners();
  }

  double? get userRate {
    return rate;
  }
}
