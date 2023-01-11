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
  bool _isLoading = true;
  @override
  void initState() {
    _isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    srvr
        .getAllFavorite()
        .then((exps) {
              setState(() {
                fav = exps.items;
                _isLoading = false;
              });
          });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Favorites'),
        ),
        drawer: Drawer(),
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            :
        fav.isEmpty?
        Column(
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
        )
            :
        ListView.builder(
          itemCount: fav.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: fav[index],
            child: ExpertWidget(),
          ),
        ),
      );

  }
}
