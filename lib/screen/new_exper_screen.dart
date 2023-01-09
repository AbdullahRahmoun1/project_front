import '../providers/category.dart';
import '../server/server.dart';
import '../widgets/expert_categories.dart';

import '../providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewExpertScreen extends StatefulWidget {
  static const routName = '/new-expert';

  @override
  State<NewExpertScreen> createState() => _EditNewExpertScreen();
}

class _EditNewExpertScreen extends State<NewExpertScreen> {
  String? value = 'Choos a category';
  var _priceFocusNode = FocusNode();
  var _disFocusNode = FocusNode();
  var _adressFocusNode = FocusNode();
  var _form = GlobalKey<FormState>();
  var _price = TextEditingController();
  var _spec = TextEditingController();
  var _dis = TextEditingController();
  var _adress = TextEditingController();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _adressFocusNode.dispose();
    _disFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<Categories>(context).items;
    List<Category> expertCat = [];
    var selectedValue = categories[0].name;
    var isCorrect = true;
    String? id = '0';
    Map<String?, dynamic> expertInfo = {
      "specialty_id": id,
      "price": 0,
      "description": "",
      "address": "",
      "specialization": ""
    };

    void _saveForm() {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        isCorrect = false;
        return;
      }
      print(expertInfo);
      _form.currentState!.save();

      _price.clear();
      _spec.clear();
      _dis.clear();
      _adress.clear();
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
              ///////////////////////////////////

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
              expertCat.isEmpty
                  ? Container(
                      width: 0,
                      height: 0,
                    )
                  : Container(
                      width: double.infinity,
                      height: 150,
                      child: ListView.builder(
                          itemCount: expertCat.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ExpertCategory(
                              expertCat[index].name,
                              expertCat[index].color,
                              expertCat[index].icon)),
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
                    id = categories
                        .firstWhere((element) => element.name == value)
                        .id;
                    print(id);
                  });
                },
                onSaved: (newValue) {
                  setState(() {
                    id = categories
                        .firstWhere((element) => element.name == newValue)
                        .id;
                    expertInfo = {
                      "specialty_id": id,
                      "price": expertInfo['price']!,
                      "description": expertInfo['description']!,
                      "address": expertInfo['address']!,
                      "specialization": "$newValue"
                    };
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth / 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Specialze',
                            ),
                            controller: _spec,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'you forgit that';
                              }
                              return null;
                            },
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
                            controller: _price,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'we don\'t have a charity';
                              }
                              if (RegExp(r'.[A-Za-z]').hasMatch(value)) {
                                return 'Invalid price !';
                              }
                              if (double.parse(value) > 1000) {
                                return 'too much babe';
                              }
                              return null;
                            },
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
                controller: _dis,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'how can you forgit that';
                  }
                  if (value.length < 5) {
                    return 'enter more info ediot';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                focusNode: _disFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_adressFocusNode);
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
                controller: _adress,
                textInputAction: TextInputAction.done,
                focusNode: _adressFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'nice let\'t meet in the street';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  expertInfo = {
                    "specialty_id": expertInfo['specialty_id']!,
                    "price": expertInfo['price']!,
                    "description": expertInfo['description']!,
                    "address": '$newValue',
                    "specialization": expertInfo['specialization']!,
                  };
                  newValue = '';
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: screenWidth / 3,
                child: ElevatedButton(
                  onPressed: () {
                    _saveForm();
                    print(expertInfo);
                    print('the id = $id');
                    if (isCorrect) {
                      Provider.of<Server>(context, listen: false)
                          .becomeExpert(expertInfo, context);
                      expertCat.add(
                        Category(
                            id: id,
                            color: categories
                                .firstWhere((element) => element.id == id)
                                .color,
                            name: expertInfo['specialization'],
                            icon: categories
                                .firstWhere((element) => element.id == id)
                                .icon),
                      );
                      print(expertCat[0]);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: <Widget>[
                              Text('Congratulations'),
                              SizedBox(
                                width: 14,
                              ),
                              Icon(
                                Icons.auto_awesome,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                          content: Text(
                              'You became ${categories.firstWhere((element) => element.id == id).name} expert successfully'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    }
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
