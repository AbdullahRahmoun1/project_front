import '../dummy_data.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';
import 'package:flutter/material.dart';

class ExperMenu extends StatefulWidget {
  @override
  State<ExperMenu> createState() => _ExperMenuState();
}

class _ExperMenuState extends State<ExperMenu> {
  @override
  Widget build(BuildContext context) {
    final ExpertId = ModalRoute.of(context)?.settings.arguments as String;
    final experts = Provider.of<Experts>(context);

    final selectedExpert = experts.findById(ExpertId);
    String? dis;
    String? phone;
    String? adress;

    String _selectedValue = selectedExpert.specialize.first.name!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton(
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
                _selectedValue = value as String;
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
