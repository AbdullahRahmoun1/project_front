import 'package:flutter/material.dart';
import '../widgets/expert_widget.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';

class FavoritScreen extends StatelessWidget {
  static final routName = '/favorit-screen';
  // final List<User> favoriteExpert;
  // FavoritScreen(this.favoriteExpert);

  @override
  Widget build(BuildContext context) {
    final favExperts = Provider.of<Experts>(context);
    final fav = favExperts.favoriteItems;
    if (fav.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Favorites'),
        ),
        drawer: Drawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/images/favorite1.png',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Your favorites list is impty',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Favorites'),
          actions: <Widget>[Icon(Icons.favorite)],
        ),
        drawer: Drawer(),
        body: ListView.builder(
          itemCount: fav.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: fav[index],
            child: ExpertWidget(),
          ),
        ),
      );
    }
  }
}
