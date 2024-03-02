import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantsPageContent extends StatelessWidget {
  RestaurantsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('restaurants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          final documents = snapshot.data!.docs;

          return ListView(
            children: [
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['name']),
                              Text(document['pizza']),
                            ],
                          ),
                          Text(document['rating'].toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        });
  }
}
