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
  var _start = TextEditingController();
  var _end = TextEditingController();
  var _price = TextEditingController();
  var _spec = TextEditingController();
  var _dis = TextEditingController();
  var _adress = TextEditingController();
  var _isDone = false;
  var _isOk = false;

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
    var days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];
    String? id = '1';
    Map<String?, dynamic> expertInfo = {
      "specialty_id": id,
      "price": 0,
      "description": "",
      "address": "",
      "specialization": ""
    };

    Map<String?, List<Map<String?, String?>>> _appointments = {
      'times': [],
    };

    Map<String?, String?> currentAppointment = {
      'day': days[0],
      'start': '',
      'end': '',
    };

    void checkWrong() {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        isCorrect = false;
        return;
      }
      isCorrect = true;
      return;
    }

    void _saveData() {
      print(expertInfo);
      _form.currentState!.save();
    }

    void _saveForm() {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        isCorrect = false;
        return;
      }

      _price.clear();
      _spec.clear();
      _dis.clear();
      _adress.clear();
    }

    void clearTime() {
      _start.clear();
      _end.clear();
    }

    void checkTimeCorrct() {
      if (int.parse(_end.text.replaceAll(RegExp(':'), '')) -
                  int.parse(_start.text.replaceAll(RegExp(':'), '')) <=
              0 ||
          _start.text == '' ||
          _end.text == '') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Wrong time'),
            content: Text('You entered worg start&end time'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'),
              ),
            ],
          ),
        );
        _isOk = false;
        return;
      }
      _isOk = true;
      return;
    }

    var selectedDay = days[0];
    void startAddDate(
      BuildContext ctx,
    ) {
      showModalBottomSheet(
        context: ctx,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        )),
        builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(top: 30, left: 40, right: 40),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Set your empty tiem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.schedule,
                      color: Colors.grey,
                      size: 30,
                    )
                  ],
                ),
                DropdownButtonFormField(
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select day',
                  ),
                  value: selectedDay,
                  items: days
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    print(value);
                    setState(
                      () {
                        selectedDay = value!;
                        currentAppointment = {
                          'day': value,
                          'start': currentAppointment['start'],
                          'end': currentAppointment['end'],
                        };
                      },
                    );
                    print(currentAppointment);
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Time Start',
                        ),
                        controller: _start,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            setState(() {
                              _start.text = value!.format(context).toString();
                            });
                          });
                        },
                        child: Text('Time')),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Time End',
                        ),
                        controller: _end,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            setState(() {
                              _end.text = value!.format(context).toString();
                            });
                          });
                        },
                        child: Text('Time')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentAppointment = {
                            'day': currentAppointment['day'],
                            'start': _start.text,
                            'end': _end.text,
                          };
                        });
                        checkTimeCorrct();
                        if (_isOk) {
                          print(currentAppointment);
                          _appointments['times']!.add(currentAppointment);
                          print(_appointments);
                          clearTime();
                        }
                      },
                      child: Text(
                        'add',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_appointments['times']!.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Wrong time'),
                              content: Text('Please enter an appointment time'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('ok'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          Navigator.of(context).pop();
                          _saveForm();
                          srvr
                              .becomeExpert(expertInfo, context);
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
                        'submit',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
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
                    print(expertInfo);
                    print('the id = $id');
                    checkWrong();
                    if (isCorrect) {
                      _saveData();
                      startAddDate(context);
                      if (_isDone) {
                        _saveForm();
                        srvr
                            .becomeExpert(expertInfo, context);
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
