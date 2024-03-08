import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class RatingTabPage extends StatelessWidget {
  const RatingTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('admins').doc("1jdrs97v1gfRWkq1Ua8jz8K8ydr1").get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final overallRating = data['overallRating'] as double? ?? 0.0;
          final ratings = data['ratings'] as Map<String, dynamic>? ?? {};

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Overall Rating:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: SmoothStarRating(
                    rating: overallRating,
                    size: 40,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    color: Colors.yellow,
                    borderColor: Colors.black,
                    spacing: 0.0,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Feedback: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      final ratingData = ratings.values.toList()[index] as Map<String, dynamic>;
                      final rating = ratingData['rating'] as double;
                      final comment = ratingData['comment'] as String;

                      return MemoizedCard(
                        comment: comment,
                        rating: rating,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MemoizedCard extends StatelessWidget {
  final String comment;
  final double rating;

  const MemoizedCard({
    required this.comment,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ratings: $rating"),
            SmoothStarRating(
              rating: rating,
              size: 30,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              color: Colors.yellow,
              borderColor: Colors.yellow,
              spacing: 0.0,
            ),
            SizedBox(height: 10),
            Text("Comment:"),
            SizedBox(height: 5),
            Text(comment),
          ],
        ),
      ),
    );
  }
}
