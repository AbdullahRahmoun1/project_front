import '../dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';

class ExpertInfo extends StatefulWidget {
  const ExpertInfo({super.key});

  @override
  State<ExpertInfo> createState() => _ExpertInfoState();
}

class _ExpertInfoState extends State<ExpertInfo> {
  @override
  Widget build(BuildContext context) {
    var ExpertId = ModalRoute.of(context)?.settings.arguments as String;
    var experts = Provider.of<Experts>(context);
    var selectedExpert = experts.findById(ExpertId);
    String? spId = '0';
    var sp =
        selectedExpert.specialize.firstWhere((element) => element.id == spId);
    var dis = sp.discription;
    var phone = selectedExpert.specialize.first.number!;
    var adress = selectedExpert.specialize.first.adress!;

    void changeSpId(String? value) {
      var newId = selectedExpert.specialize
          .firstWhere(
            (element) => element.name == value,
          )
          .id;

      spId = newId;
      sp =
          selectedExpert.specialize.firstWhere((element) => element.id == spId);
      dis = sp.discription;
    }

    var _selectedValue = selectedExpert.specialize[0].name!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
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
            value: _selectedValue,
            items: selectedExpert.specialize
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
                changeSpId(value);
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
              phone,
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
              adress,
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
              onPressed: null,
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
