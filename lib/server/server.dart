import 'package:consulting_app/modles/specialize.dart';
import 'package:consulting_app/providers/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../providers/experts.dart';
import '../modles/http_exception.dart';

final String baseUrl = '127.0.0.1';
String token = "";

class srvr {
  static Future<String?> getToken() async {
    if (token.isEmpty) {
      final storage = new FlutterSecureStorage();
      String? value = await storage.read(key: 'token');
      token = value!;
    }
    print(token);
    return token;
  }

  static Future<Map<String,dynamic>> getHome(items) async {
    try {
      var result={'statusCode':400};
      final url = Uri.parse('http://$baseUrl:8000/api/home');
      var token = await getToken();
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(url, headers: header);
      final extractData =
          json.decode(response.body) ;
      for (var i = 0; i < items.length; i++) {
        items[i].name = extractData['data']['Specialities'][i]['specialtyName'];
      }
      print(extractData['data']);
      return extractData;
    } catch (e) {
      print(e);
    }
    return {'msg':'failed'};
  }

  static Future<Map<String, dynamic>> getUserData(String? id) async {
    final url = Uri.parse('http://$baseUrl:8000/api/user/$id');
    var token = await getToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: header);
    final extraxtData = json.decode(response.body) as Map<String, dynamic>;
    List asd = extraxtData['data']['Expertise'];
    List<Specialize> dsa = [];
    for (int i = 0; i < asd.length; i++) {
      dsa.add(Specialize(
          asd[i]['id'].toString(),
          asd[i]['specialization'],
          asd[i]['description'],
          extraxtData['data']['phone'],
          asd[i]['address'],
          asd[i]['price'].toString(),
          double.parse(asd[i]['rate'])));
    }
    return {
      'name': extraxtData['data']['name'],
      'phone': extraxtData['data']['phone'],
      'isExp': extraxtData['data']['isExp'],
      'isFav': extraxtData['data']['isFav'],
      'image': extraxtData['data']['image'],
      'specialize': dsa,
      'money': extraxtData['data']['money'],
      'totalRate': extraxtData['data']['Total ratings'],
    };
  }

  static Future<void> becomeExpert(
      Map<String?, dynamic> body) async {
    var token = await getToken();
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

  static Future<Experts> search(String cat, String query) async {
    Experts exps = Experts();
    var token = await getToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url =
        Uri.parse('http://$baseUrl:8000/api/specialty/$cat?query=$query');
    final response = await http.get(url, headers: header);
    final JSONresponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw HttpException(JSONresponse['userMessage']);
    }
print( JSONresponse);
    List listOfExps = (JSONresponse['data']);
    for (int i = 0; i < listOfExps.length; i++) {
      exps.addExpert(User(
          id: listOfExps[i]['user_id'].toString(), name: listOfExps[i]['name']));
    }
    print(exps.items);
    if (exps.items.length == 0) {
      throw Exception();
    }
    return exps;
  }

  static Future<Map<String, dynamic>> expertReservation() async {
    var token = await getToken();
    var url = Uri.parse('http://$baseUrl:8000/api/reservation');
    var extractedData;
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await http.get(url, headers: header);
      extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(json.decode(response.body));
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
    return extractedData;
  }

  static Future<bool> manageLove(String expertId) async {
    bool result = false;
    var token = await getToken();
    var url = Uri.parse('http://$baseUrl:8000/api/favorite');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept-Encoding': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = {'expert_id': expertId};
    try {
      var response =
          await http.post(url, headers: header, body: json.encode(body));

      print("fafa");
      if (response.statusCode == 200) result = true;
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<Map<String, dynamic>> uploadImage(String image) async {
    String result = "";
    final url = Uri.parse('http://$baseUrl:8000/api/updateImage');
    var token = await getToken();
    Map<String, String> header = {
      'Content-Type': 'multipart/form-data',
      'Accept-Encoding': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    var request = new http.MultipartRequest("POST", url);
    request.headers.addAll(header);
    request.files.add(await http.MultipartFile.fromPath('image', image));
    var response = await request.send();
    var data = await response.stream.bytesToString();
    var dota = json.decode(data);
    if (response.statusCode == 200) {
      result = dota['data'];
      return {'msg': "", 'path': result};
    }
    return {'msg': dota['userMessage'], 'path': ""};
  }

  static Future<Experts> getAllFavorite() async {
    Experts exps = Experts();
    var token = await getToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('http://$baseUrl:8000/api/favorite');
    final response = await http.get(url, headers: header);
    print('----------------------------------------');
    print(response.body);
    final JSONresponse = json.decode(response.body);

    print("getFavs");

    if (response.statusCode != 200) {
      print("Error in getFavs");
      throw HttpException(JSONresponse['userMessage']);
    }
    List listOfExps = JSONresponse['data'];
    for (int i = 0; i < listOfExps.length; i++) {
      print(listOfExps[i]['specializations']);
      exps.addExpert(User(
          id: listOfExps[i]['id'].toString(),
          name: listOfExps[i]['name'],
          isFavorit: true,
          imagePath: listOfExps[i]['image'],
          spForSearch: listOfExps[i]['specializations']));
    }
    return exps;
  }

  static Future<bool> addTime(expertId,times) async{
    bool result=false;
    var token = await getToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('http://$baseUrl:8000/api/time');
    final response = await http.post(url, headers: header,body: json.encode(times));
    if(response.statusCode==200)result=true;
    print(response.body);
    return result;
  }
}
