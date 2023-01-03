import 'user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modles/specialize.dart';

class Experts with ChangeNotifier {
  List<User> _items = [
    User(
      id: '0',
      name: 'Alaa shibany',
      imagePath: 'assets/images/kaiba.png',
      category: ['Medical'],
      spForSearch: ['Dendist'],
      rate: 4,
      specialize: [
        Specialize('0', 'Medical/Dendist', 'He can fix your teeth ',
            '+963980218090', '7586 Edgefield StreetRego Park NY 11374'),
      ],
      isExpert: true,
    ),
    User(
      id: '1',
      name: 'Abd ullah rahmon',
      imagePath: 'assets/images/rahmon.png',
      category: ['Bussniss', 'Games'],
      spForSearch: ['Big company', 'Horror games'],
      rate: 2,
      specialize: [
        Specialize(
            '0',
            'Bussniss/Big company',
            'He learned in damascus univarcity so GG',
            '+963980218111',
            '7586 Edgefield StreetRego Park NY 11374'),
        Specialize('1', 'Games/Horror games', 'He is a streemer',
            '+963980222111', '7586 Edgefield StreetRego Park NY 11374'),
      ],
      isExpert: true,
    ),
    User(
      id: '2',
      name: 'Abd ullah mosa',
      imagePath: 'assets/images/mosa.png',
      category: ['Familly'],
      spForSearch: ['Divorce'],
      rate: 1,
      specialize: [
        Specialize('0', 'Familly/Divorce', 'Every one come to him divorce',
            '+9639340218090', '7586 Edgefield StreetRego Park NY 11374'),
      ],
      isExpert: true,
    ),
    User(
      id: '3',
      name: 'Bahaa nokta',
      imagePath: 'assets/images/bahaa.png',
      spForSearch: ['Studing'],
      category: ['Profissional'],
      rate: 3,
      specialize: [
        Specialize(
            '0',
            'Profissional/Studing',
            'The second student in the univarcity',
            '+963980218490',
            '7586 Edgefield StreetRego Park NY 11374'),
      ],
      isExpert: true,
    ),
  ];

  User findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<User> get favoriteItems {
    return _items.where((element) => element.isFavorit).toList();
  }

  List<User> get items {
    return [..._items];
  }

  List<User> searchItem(String? name) {
    return _items.where((element) => element.name == name).toList();
  }

  void changeRate(String id, double? Newrate) {
    _items.firstWhere((element) => element.id == id).rate = Newrate;
    notifyListeners();
  }

  void addExpert() {
    notifyListeners();
  }

  Set<String?> get specializes {
    Set<String?> sp = {};
    for (var i = 0; i < _items.length; i++) {
      for (var j = 0; j < _items[i].spForSearch.length; j++) {
        sp.add(_items[i].spForSearch[j]);
      }
    }
    return sp;
  }
}
