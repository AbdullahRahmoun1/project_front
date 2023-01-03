import 'package:flutter/material.dart';
import '../screen/get_started_activate.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.deepPurple,
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
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
