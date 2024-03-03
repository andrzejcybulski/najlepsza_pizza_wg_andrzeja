// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('restaurants')
            .orderBy('rating', descending: true)
            .snapshots(),
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
                Dismissible(
                  key: ValueKey(document.id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) {
                    FirebaseFirestore.instance
                        .collection("restaurants")
                        .doc(document.id)
                        .delete();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                          child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          GestureDetector(
                            onLongPress: () => FirebaseFirestore.instance
                                .collection("restaurants")
                                .doc(document.id)
                                .delete(),
                            child: Container(
                              color: Colors.lightBlue,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(document['name']),
                                            Text(document['pizza']),
                                          ],
                                        ),
                                        Text(document['rating'].toString()),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Container(height: 1, color: Colors.black),
                                    const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document['description'],
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: -15,
                              right: 130,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(
                                    side: BorderSide(width: 36),
                                  ),
                                ),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("restaurants")
                                      .doc(document.id)
                                      .delete();
                                },
                                child: const Icon(Icons.delete, size: 20),
                              )),
                          // Positioned(
                          //   bottom: -15,
                          //   right: 170,
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       shape: const CircleBorder(
                          //         side: BorderSide(width: 36),
                          //       ),
                          //     ),
                          //     onPressed: () {
                          //       showDialog(
                          //         context: context,
                          //         builder: (BuildContext context) {
                          //           return UpdateWidget(document: document);
                          //         },
                          //       );
                          //     },
                          //     child: const Icon(Icons.edit, size: 20),
                          //   ),
                          // )
                        ],
                      ))),
                ),
              ],
            ],
          );
        });
  }
}

// class UpdateWidget extends StatefulWidget {
//   UpdateWidget({
//     super.key,
//     required this.document,
//   });

//   final QueryDocumentSnapshot<Map<String, dynamic>> document;

//   @override
//   State<UpdateWidget> createState() => _UpdateWidgetState();
// }

// class _UpdateWidgetState extends State<UpdateWidget> {
//   var updateRestaurantName = '';
//   var updatePizzaName = '';
//   var updateDescription = '';

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//           15,
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(10),
//       child: SingleChildScrollView(
//         child: Stack(
//           clipBehavior: Clip.none,
//           alignment: Alignment.center,
//           children: <Widget>[
//             Container(
//               width: double.infinity,
//               height: 700,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(width: 2, color: Colors.white),
//                   color: Colors.blueAccent),
//               padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
//               child: Column(
//                 children: [
//                   Form(
//                     child: Column(
//                       children: <Widget>[
//                         TextField(
//                           controller: TextEditingController(
//                               text: widget.document['name']),
//                           decoration:
//                               const InputDecoration(hintText: 'Restauracja'),
//                         ),
//                         TextField(
//                           controller: TextEditingController(
//                               text: widget.document['pizza']),
//                           decoration: const InputDecoration(hintText: 'Pizza'),
//                         ),
//                         TextField(
//                           controller: TextEditingController(
//                               text: widget.document['description']),
//                           decoration: const InputDecoration(hintText: 'Opis'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                       onPressed: () {
//                         // final data = {
//                         //   'name': updateRestaurantName,
//                         //   'pizza': updatePizzaName,
//                         //   'description': updateDescription,
//                         // };

//                         FirebaseFirestore.instance
//                             .collection("restaurants")
//                             .doc('name')
//                             .update;
//                         FirebaseFirestore.instance
//                             .collection("restaurants")
//                             .doc('pizza')
//                             .update;
//                         FirebaseFirestore.instance
//                             .collection("restaurants")
//                             .doc('restaurants')
//                             .update;
//                       },
//                       child: Text('Zaktualizuj'))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
