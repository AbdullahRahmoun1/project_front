import 'package:consulting_app/screen/profile_screen.dart';

import '../widgets/categories_list.dart';
import '../providers/categories.dart';
import '../widgets/home_favorites.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/app_drawer.dart';
import '../server/server.dart';

class HomeSceen extends StatefulWidget {
  static final routName = '/home';

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  var _isInit = true;
  var _isLoaded = false;
  bool _isExpert = false;
  String _userName = '';
  String _userPhone = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoaded = true;
      });
      var items = Provider.of<Categories>(context).items;
      try {
        dynamic extraxtData =
            await Provider.of<Server>(context).getUserData(-1, context);

        _userName = extraxtData['name'];
        _userPhone = extraxtData['phone'];
        _isExpert = extraxtData['isExp'];
      } catch (e) {
        print(e);
      }

      Provider.of<Server>(context, listen: false)
          .getHome(items, context)
          .then((_) {
        setState(() {
          _isLoaded = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<Categories>(
      context,
    );
    final categories = categoriesData.items;
    final favExperts = Provider.of<Experts>(context);
    final fav = favExperts.items;
    Widget getFavorite() {
      if (fav.isEmpty) {
        return Container(
          alignment: Alignment.bottomLeft,
          width: 80,
          height: 80,
          margin: EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
          child: Row(
            children: <Widget>[
              Lottie.asset('assets/images/love.json'),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  'your favorite list is empty',
                  style: TextStyle(
                      color: Color.fromARGB(255, 115, 114, 114),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        );
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: fav
                .map(
                  (e) => HomeFavorites(
                    e.name!,
                    e.imagePath!,
                  ),
                )
                .toList(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 29,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileScreen.routName);
            },
          ),
          _isExpert
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 29,
                  ),
                )
              : Container()
        ],
      ),
      drawer: AppDrawer(_userName, _userPhone),
      body: _isLoaded
          ? Center(
              child: Container(
                width: 300,
                height: 300,
                child: Lottie.asset('assets/images/loading.json'),
              ),
            )
          : ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Text(
                    "Categories ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                CategoriesList(),
                SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Text(
                    "Favorites ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                getFavorite()
              ],
            ),
    );
  }
}
