import 'package:consulting_app/server/server.dart';
import 'package:flutter/material.dart';
import '../widgets/expert_widget.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/experts.dart';

class FavoritScreen extends StatefulWidget {
  static final routName = '/home';

  @override
  State<FavoritScreen> createState() => _FavoritScreen();
}

class _FavoritScreen extends State<FavoritScreen> {
  static final routName = '/favorit-screen';
  List<User> fav = Experts().items;
  var _isLoaded = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Server>(context)
        .getAllFavorite(context)
        .then((exps) {
              setState(() {
                fav = exps.items;
                _isLoaded = false;
              });
          });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
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
        body: _isLoaded
            ? Center(
          child: CircularProgressIndicator(),
        )
            :ListView.builder(
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
