import 'package:consulting_app/widgets/raiting.dart';

import './screen/tabs_screen.dart';

import './screen/auth-screen.dart';

import './providers/categories.dart';
import './providers/experts.dart';
import 'package:provider/provider.dart';

import './screen/favorit_screen.dart';
import './screen/home_screen.dart';

import 'screen/expert_info_screen.dart';

import './screen/seach_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final List<User> _favoriteExpert = [];

  // void _toggleFavorite(String expertId) {
  //   final existingIndex =
  //       _favoriteExpert.indexWhere((Expert) => Expert.id == expertId);

  //   if (existingIndex >= 0) {
  //     setState(() {
  //       _favoriteExpert.removeAt(existingIndex);
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteExpert.add(
  //         // Dummy_Experts.firstWhere((experte) => experte.id == expertId),
  //       );
  //     });
  //   }
  // }

  // bool _isExpertFavorite(String id) {
  //   return _favoriteExpert.any((expert) => expert.id == id);
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Experts(),
        ),
        ChangeNotifierProvider(
          create: (context) => Categories(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
                bodyText2: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
                headline1: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
                headline2: const TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
        ),
        home: AuthScreen(),
        routes: {
          TabsScreen.routName: (context) => TabsScreen(),
          HomeSceen.routName: (context) => HomeSceen(),
          SearchScreen.routName: (context) => SearchScreen(),
          ExpertInfoScreen.routName: (context) => ExpertInfoScreen(),
          FavoritScreen.routName: (context) => FavoritScreen()
        },
        title: 'Flutter Demo',
      ),
    );
  }
}
