import '../screen/favorit_screen.dart';
import 'package:flutter/material.dart';

import '../server/server.dart';

class HomeFavorites extends StatelessWidget {
  final String name;
  final String imagePath;

  HomeFavorites(this.name, this.imagePath);

  void getFavorite(BuildContext context) {
    Navigator.of(context).pushNamed(FavoritScreen.routName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => getFavorite(context),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://$baseUrl:8000/api/" + imagePath),
              radius: 50,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
  }
}
