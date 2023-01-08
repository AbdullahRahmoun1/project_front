import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import './new_exper_screen.dart';

class GetStartedActivate extends StatelessWidget {
  static const routName = '/get-started';
  const GetStartedActivate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(1, 103, 58, 183),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/cosn.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromRGBO(255, 255, 255, 190),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('You have to pay 500 coins'),
                        content: Text('are you sure you want to be expert?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  NewExpertScreen.routName);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.deepPurple,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/crown.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
