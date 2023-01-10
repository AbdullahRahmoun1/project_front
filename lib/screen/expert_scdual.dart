import 'package:flutter/material.dart';
import '../server/server.dart';

class ExpertScdual extends StatefulWidget {
  static const nameRout = '/expert-scdual';
  const ExpertScdual({super.key});

  @override
  State<ExpertScdual> createState() => _ExpertScdualState();
}

class _ExpertScdualState extends State<ExpertScdual> {
  @override
  Widget build(BuildContext context) {
    var _isInit = true;
    var _isLoaded = false;
    var reservations;
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
        try {
          dynamic extractedData = await srvr.expertReservation(context);
          setState(() {
            reservations = extractedData['data']['Reservations'];
          });
        } catch (e) {
          print(e);
        }
      }
      _isInit = false;
      super.didChangeDependencies();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Scdual'),
        actions: <Widget>[
          Icon(Icons.schedule),
        ],
      ),
      body: _isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: TextButton(
                onPressed: () {
                  print(reservations);
                },
                child: Text('try'),
              ),
            ),
    );
  }
}
