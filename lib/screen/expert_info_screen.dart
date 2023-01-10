import 'package:flutter/material.dart';
import '../widgets/raiting.dart';
import '../widgets/expert_info.dart';
import 'package:provider/provider.dart';
import '../server/server.dart';

class ExpertInfoScreen extends StatefulWidget {
  static final routName = '/expert-info';

  @override
  State<ExpertInfoScreen> createState() => _ExpertInfoScreenState();
}

class _ExpertInfoScreenState extends State<ExpertInfoScreen> {
  void back(BuildContext context) {
    Navigator.of(context).pop(ExpertInfoScreen.routName);
  }

  double rating = 0;
  String? ExpertId;
  Map<String, dynamic>? selectedExpert;
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    ExpertId = ModalRoute.of(context)?.settings.arguments as String?;
    srvr
            .getUserData(ExpertId, context)
            .then((exp) => {
              setState(() {
                _isLoading = true;
                selectedExpert = exp;
                _isLoading = false;
              })
        });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Icon fav = Icon(
      Icons.favorite,
      color: Colors.white,
    );
    Icon favIcon() {
      setState(() {
        fav = Icon(
          selectedExpert?['isFav'] ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        );
      });
      return fav;
    }

    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      //thins container for avatar and name
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: double.infinity,
                      height: 320,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF673AB7),
                            Colors.purple,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => back(context),
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 72,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage("http://$baseUrl:8000/api/"+selectedExpert?['image']),
                              backgroundColor: Colors.white,
                              radius: 70,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Text(
                              selectedExpert?['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 20,
                        child: IconButton(
                          icon: (Icon(
                            selectedExpert?['isFav']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          )),
                          onPressed: () => setState(() {
                                srvr.manageLove(ExpertId.toString(), context);
                                selectedExpert?['isFav']=!selectedExpert?['isFav'];
                          }),
                        )),
                  ],
                ),
                Container(
                  // this container for info
                  margin: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ExpertInfo(),
                      ],
                    ),
                  ),
                ),
                Container(
                  //This container for rating
                  margin: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 10),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: Rating(),
                ),
              ],
      ),
    );
  }
}
