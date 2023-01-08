import 'package:consulting_app/providers/user.dart';
import 'package:consulting_app/server/auth.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../providers/experts.dart';
import '../modles/http_exception.dart';

final String baseUrl='127.0.0.1';

class Server with ChangeNotifier {
  String? _getToken(context) {
    return Provider.of<Auth>(context, listen: false).token;
  }

  Future<void> FetchCategory(items, context) async {
    try {
      final url = Uri.parse('http://$baseUrl:8000/api/home');
      var token = _getToken(context);
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: header);
      final extractData =
      json.decode(response.body) as LinkedHashMap<String, dynamic>;
      for (var i = 0; i < items.length; i++) {
        items[i].name = extractData['data']['Specialities'][i]['specialtyName'];
      }
      print(response.statusCode);
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getUserData(int? id, context) async {
    final url = Uri.parse('http://$baseUrl:8000/api/user/-1');
    var token = _getToken(context);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: header);
    final extraxtData = json.decode(response.body) as Map<String, dynamic>;
    return {
      'name': extraxtData['data']['name'],
      'phone': extraxtData['data']['phone'],
      'isExp': extraxtData['data']['isExp']
    };
  }

  Future<List<Experts>> search(String cat,String query,context)async{
    List<Experts> exps=[];
    return exps;
  }

  Future<Experts> getAllFavorite(context) async {
    Experts exps=Experts();

    final url = Uri.parse('http://$baseUrl:8000/api/favorite');

    var token = _getToken(context);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: header);
    final JSONresponse = json.decode(response.body);

    if (response.statusCode!=200){
      throw HttpException(JSONresponse['userMessage']);
    }

    List listOfExps=JSONresponse['data'];

    for (int i=0;i<listOfExps.length;i++){
      exps.items[i]=User(id: listOfExps[i]['id'], name: listOfExps[i]['name']);
    }
    return exps;
  }

}