import 'package:consulting_app/providers/user.dart';
import '../screen/expert_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../server/server.dart';

class ExpertWidget extends StatefulWidget {
  @override
  State<ExpertWidget> createState() => _ExpertWidgetState();
}

class _ExpertWidgetState extends State<ExpertWidget> {
  @override
  Widget build(BuildContext context) {
    var expert = Provider.of<User>(context);

    String getSubtitle() {
      if (expert.specialize.length > 2) {
        var e1 = expert.spForSearch[0].toString();
        var e2 = expert.spForSearch[1].toString();
        return '$e1  $e2 ...';
      }

      return expert.spForSearch.join(' . ');
    }

    double? rate = expert.rate;
    double getRate() {
      setState(() {
        rate = expert.rate;
      });
      return rate!;
    }

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        ExpertInfoScreen.routName,
        arguments: expert.id,
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/cosn.png'),
            radius: 30,
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/cosn.png'),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromRGBO(255, 255, 255, 255),
                  backgroundImage: NetworkImage(
                      "http://$baseUrl:8000/api/" + expert.imagePath!),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
                semanticLabel: '5',
              ),
              Text(
                rate.toString(),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          dense: false,
          title: Text(
            expert.name!,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            getSubtitle(),
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
