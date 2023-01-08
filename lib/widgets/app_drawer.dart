import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/get_started_activate.dart';
import '../server/auth.dart';
import './my_header_drawer.dart';

class AppDrawer extends StatelessWidget {
  String? userName;
  String? userPhone;

  AppDrawer(this.userName, this.userPhone);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(),
                child: Image(
                  image: AssetImage('assets/images/stars.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Color.fromRGBO(81, 45, 168, 90),
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 104,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/kaiba.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      userName!,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      userPhone!,
                      style: TextStyle(
                        color: Colors.deepPurple[200],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.auto_awesome,
            ),
            title: Text('Activate'),
            onTap: () {
              Navigator.of(context).pushNamed(GetStartedActivate.routName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: Text('Log out'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
