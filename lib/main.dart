import './providers/category.dart';
import 'package:flutter/material.dart';
import './providers/categories.dart';
import './providers/experts.dart';
import 'package:provider/provider.dart';

import './screen/get_started_activate.dart';
import './screen/tabs_screen.dart';
import './screen/auth-screen.dart';
import './screen/favorit_screen.dart';
import './screen/home_screen.dart';
import 'screen/expert_info_screen.dart';
import './screen/seach_screen.dart';
import './screen/new_exper_screen.dart';
import './server/auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Experts(),
        ),
        ChangeNotifierProvider(
          create: (context) => Categories(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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
          home: auth.isAuth ? TabsScreen() : AuthScreen(),
          routes: {
            GetStartedActivate.routName: (context) => GetStartedActivate(),
            TabsScreen.routName: (context) => TabsScreen(),
            HomeSceen.routName: (context) => HomeSceen(),
            SearchScreen.routName: (context) => SearchScreen(),
            ExpertInfoScreen.routName: (context) => ExpertInfoScreen(),
            FavoritScreen.routName: (context) => FavoritScreen(),
            NewExpertScreen.routName: (context) => NewExpertScreen(),
          },
          title: 'Flutter Demo',
        ),
      ),
    );
  }
}
