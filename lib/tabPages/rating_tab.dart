import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class RatingTabPage extends StatefulWidget {
  const RatingTabPage({Key? key}) : super(key: key);

  @override
  State<RatingTabPage> createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  List<Map<String, dynamic>> ratingsData = [];

  @override
  void initState() {
    super.initState();
    fetchRatingsData();
  }

  void fetchRatingsData() {
    DatabaseReference feedbackRef = FirebaseDatabase.instance
        .ref()
        .child("admin")
        .child("1jdrs97v1gfRWkq1Ua8jz8K8ydr1")
        .child("feedback");

    feedbackRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic> data = snap.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          double rating = double.parse(value['ratings'].toString());
          String comment = value['comment'] ?? "No comment provided";
          ratingsData.add({
            'rating': rating,
            'comment': comment,
          });
        });
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: ratingsData.length,
        itemBuilder: (context, index) {
          double rating = ratingsData[index]['rating'];
          String comment = ratingsData[index]['comment'];

          return ListTile(
            title: Row(
              children: [
                SmoothStarRating(
                  rating: rating,
                  size: 20,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  color: Colors.amber,
                  borderColor: Colors.amber,
                  starCount: 5,
                  allowHalfRating: true,
                ),
                SizedBox(width: 10),
                Text('$rating'),
              ],
            ),
            subtitle: Text(comment),
          );
        },
      ),
    );
  }
}

