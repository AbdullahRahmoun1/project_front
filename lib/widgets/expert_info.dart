import 'package:consulting_app/modles/specialize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../server/server.dart';

class ExpertInfo extends StatefulWidget {
  const ExpertInfo({super.key});

  @override
  State<ExpertInfo> createState() => _ExpertInfoState();
}

class _ExpertInfoState extends State<ExpertInfo> {
  bool _isLoading = true;
  String? ExpertId = '';
  var selectedExpert = {};
  String? spId = '';
  var sp = Specialize('', '', '', '', '', '');
  String? dis = '';
  String? phone = '';
  String? adress = '';
  var _start = TextEditingController();
  var _end = TextEditingController();
  var _isOk = false;

  @override
  void didChangeDependencies() {
    ExpertId = ModalRoute.of(context)?.settings.arguments as String;
    srvr.getUserData(ExpertId, context).then((selectedExpert) {
      setState(() {
        spId = '0';
        print("asdfghjklrxhtcfvygbhun");
        print(selectedExpert['specialize'][0].name);
        sp = selectedExpert['specialize']
            .firstWhere((element) => true /*element.id == spId*/);
        dis = sp.discription;
        phone = selectedExpert['specialize'].first.number!;
        adress = selectedExpert['specialize'].first.adress!;
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];

    Map<String?, String?> currentAppointment = {
      'day': days[0],
      'start': '',
      'end': '',
    };

    var selectedDay = days[0];

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

    void startTakeAppointment(
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
                      'Set your empty time',
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
                          //here we have to do thing
                        }
                      },
                      child: Text(
                        'add',
                        style: TextStyle(fontSize: 18),
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

    void changeSpId(String? value) {
      var newId = selectedExpert['specialize']
          .firstWhere(
            (element) => element.name == value,
          )
          .id;

      spId = newId;
      sp = selectedExpert['specialize']
          .firstWhere((element) => element.id == spId);
      dis = sp.discription;
    }

    //var _selectedValue = selectedExpert['specialize'][0].name;
    return Container(
      padding: const EdgeInsets.all(20),
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButtonFormField(
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select specialize',
                  ),
                  value: selectedExpert['specialize'][1].name,
                  items: selectedExpert['specialize']
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.name!),
                          value: e.name,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      //_selectedValue = value!;
                      changeSpId(value.toString());
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Text(
                    'Description :',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    dis!,
                    style: TextStyle(
                      color: Color.fromARGB(255, 113, 113, 113),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  'Contact :',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    phone!,
                    style: TextStyle(
                      color: Color.fromARGB(255, 113, 113, 113),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  'Address :',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    adress!,
                    style: TextStyle(
                      color: Color.fromARGB(255, 113, 113, 113),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.deepPurple),
                    ),
                    onPressed: () {
                      startTakeAppointment(context);
                    },
                    child: Text(
                      'Get appointment',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
