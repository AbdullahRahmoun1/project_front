import 'package:consulting_app/providers/category.dart';

import '../providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewExpertScreen extends StatefulWidget {
  static const routName = '/new-expert';

  @override
  State<NewExpertScreen> createState() => _EditNewExpertScreen();
}

class _EditNewExpertScreen extends State<NewExpertScreen> {
  String? value = 'Choos a category';
  var _priceFocusNode = FocusNode();
  var _disFocusNode = FocusNode();
  var _adress = FocusNode();
  var _form = GlobalKey<FormState>();
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _adress.dispose();
    _disFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<Categories>(context).items;

    var selectedValue = categories[0].name;

    var expertInfo = {
      "specialty_id": 0,
      "price": 0,
      "description": "",
      "address": "",
      "specialization": ""
    };

    void _saveForm() {
      _form.currentState!.save();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    DropdownMenuItem<String?> buildMenuItem(Category item) => DropdownMenuItem(
          value: item.name,
          child: Text(
            item.name!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text('Royal pass'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                'creat an expert',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.deepPurple,
                  size: 30,
                ),
                onSaved: (newValue) {
                  expertInfo = {
                    "specialty_id": categories
                        .firstWhere((element) => element.name == selectedValue)
                        .id,
                    "price": expertInfo['price']!,
                    "description": expertInfo['description']!,
                    "address": expertInfo['address']!,
                    "specialization": expertInfo['specialization']!
                  };
                },
                decoration: InputDecoration(
                  labelText: 'Select category',
                ),
                value: selectedValue,
                items: categories
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e.name!),
                        value: e.name,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              SafeArea(
                child: Column(
                  children: List.generate(
                    1,
                    (index) => Row(
                      children: [
                        SizedBox(
                          width: screenWidth / 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Specialze',
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            },
                            onSaved: (newValue) {
                              expertInfo = {
                                "specialty_id": expertInfo['specialty_id']!,
                                "price": expertInfo['price']!,
                                "description": expertInfo['description']!,
                                "address": expertInfo['address']!,
                                "specialization": "$newValue"
                              };
                            },
                          ),
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          width: screenWidth / 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Price',
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _priceFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_disFocusNode);
                            },
                            onSaved: (newValue) {
                              expertInfo = {
                                "specialty_id": expertInfo['specialty_id']!,
                                "price": '$newValue',
                                "description": expertInfo['description']!,
                                "address": expertInfo['address']!,
                                "specialization": expertInfo['specialization']!,
                              };
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Discription',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _disFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_adress);
                },
                onSaved: (newValue) {
                  expertInfo = {
                    "specialty_id": expertInfo['specialty_id']!,
                    "price": expertInfo['price']!,
                    "description": '$newValue',
                    "address": expertInfo['address']!,
                    "specialization": expertInfo['specialization']!,
                  };
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'adress',
                ),
                textInputAction: TextInputAction.done,
                focusNode: _adress,
                onSaved: (newValue) {
                  expertInfo = {
                    "specialty_id": expertInfo['specialty_id']!,
                    "price": expertInfo['price']!,
                    "description": expertInfo['description']!,
                    "address": '$newValue',
                    "specialization": expertInfo['specialization']!,
                  };
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth / 2,
                child: ElevatedButton(
                  onPressed: () {
                    _saveForm();
                    print(expertInfo);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
