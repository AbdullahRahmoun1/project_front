import 'package:consulting_app/providers/category.dart';

import '../providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewExpertScreen extends StatefulWidget {
  static const routName = '/new-expert';

  @override
  State<NewExpertScreen> createState() => _EditNewExpertScreen();
}

class _EditNewExpertScreen extends State<NewExpertScreen> {
  final _priceFocusNode = FocusNode();
  final _disFocusNode = FocusNode();
  final _adress = FocusNode();

  String? value = 'Choos a category';
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).items;
    var _selectedValue = categories[0].name!;
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
        title: Text('Maneging expert'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          child: ListView(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/crown.png',
                  fit: BoxFit.cover,
                ),
              ),
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
                decoration: InputDecoration(
                  labelText: 'Select category',
                ),
                value: _selectedValue,
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
                    _selectedValue = value!;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
