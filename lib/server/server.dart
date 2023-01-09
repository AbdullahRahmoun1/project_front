import 'dart:ffi';

import 'package:consulting_app/providers/user.dart';
import 'package:consulting_app/server/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../providers/experts.dart';
import '../modles/http_exception.dart';

final String baseUrl = '127.0.0.1';
String token="";
class Server with ChangeNotifier {

  Future<String?> _getToken(context) async {
    if(token.isEmpty) {
      final storage = new FlutterSecureStorage();
      String ?value = await storage.read(key: 'token');
      token=value!;
    }
    print(token);
    return token;
  }

  Future<void> getHome(items, context) async {
    try {
      final url = Uri.parse('http://$baseUrl:8000/api/home');
      var token = await _getToken(context);
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
    var token = await _getToken(context);
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

  Future<void> becomeExpert(
      Map<String?, dynamic> body, BuildContext context) async {
    var token = await _getToken(context);
    var url = Uri.parse('http://$baseUrl:8000/api/expert');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      print(json.encode(body));
      final response =
          await http.post(url, headers: header, body: json.encode(body));
      print(response.body);
      print(response.statusCode);
      print(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  }

  Future<Experts> search(String cat, String query, context) async {
    Experts exps = Experts();
    var token =await _getToken(context);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('http://$baseUrl:8000/api/specialty/$cat?query=$query');
    final response = await http.get(url, headers: header);
    final JSONresponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw HttpException(JSONresponse['userMessage']);
    }

    List listOfExps = JSONresponse['data'];
    for (int i = 0; i < listOfExps.length; i++) {
      exps.addExpert(User(id: listOfExps[i]['id'].toString(), name: listOfExps[i]['name']));
    }
    return exps;
  }
  Future<bool>manageLove(String expertId,bool love,context)async{
     bool result=false;
     var token = await _getToken(context);
     var url = Uri.parse('http://$baseUrl:8000/api/favorite');
     Map<String, String> header = {
       'Content-Type': 'application/json',
       'Accept-Encoding': 'application/json',
       'Authorization': 'Bearer $token',
     };
     var body={
       'expert_id':expertId
     };
     try {
       var response;
       if(love){
          response=
          await http.post(url, headers: header, body: json.encode(body));
       }else {
         response=
         await http.delete(url, headers: header, body: json.encode(body));
       }
       if(response.statusCode==200)result=true;
     } catch (e) {
       print(e);
     }
     return result;
  }

  Future<Experts> getAllFavorite(context) async {
    Experts exps = Experts();
    var token = await _getToken(context);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('http://$baseUrl:8000/api/favorite');
    final response = await http.get(url, headers: header);
    final JSONresponse = json.decode(response.body);

    print("getFavs");

    if (response.statusCode != 200) {
      print("Error in getFavs");
      throw HttpException(JSONresponse['userMessage']);
    }
    List listOfExps = JSONresponse['data'];
    for (int i = 0; i < listOfExps.length; i++) {
      exps.addExpert(User(
                id: listOfExps[i]['id'].toString(),
                name: listOfExps[i]['name'],
                isFavorit: true,
                imagePath: listOfExps[i]['image'],
                //specialize:
                ));
    }
    return exps;
  }
}