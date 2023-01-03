import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../providers/experts.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    final ExpertId = ModalRoute.of(context)?.settings.arguments as String;
    final experts = Provider.of<Experts>(context, listen: false);
    final selectedExpert = experts.findById(ExpertId);
    double? _Rating = selectedExpert.rate;

    Widget buildRatring() => RatingBar.builder(
          initialRating: _Rating!,
          minRating: 1,
          updateOnDrag: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: 7),
          itemBuilder: ((context, index) => const Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
              )),
          onRatingUpdate: (rating) => setState(() {
            _Rating = rating;
            experts.changeRate(ExpertId, rating);
          }),
        );

    void showRating() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Rating this expert',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Please leave a star rating.',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  buildRatring(),
                ]),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ))
            ],
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Address :',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          child: RatingBar.builder(
            initialRating: _Rating!,
            minRating: 1,
            updateOnDrag: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 7),
            itemBuilder: ((context, index) => const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.amber,
                )),
            onRatingUpdate: (rating) => setState(() {
              _Rating = rating;
              selectedExpert.rate = rating;
            }),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50),
          child: Text(
            'Rating $_Rating',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: OutlinedButton(
            onPressed: () => showRating(),
            child: Text(
              'Rating now',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
      ],
    );
  }
}
