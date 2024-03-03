import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddOpinionPageContent extends StatefulWidget {
  AddOpinionPageContent({
    super.key,
  });

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var pizzaName = '';
  var descriptionName = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Restauracja',
            ),
            onChanged: (newValue) {
              setState(() {
                restaurantName = newValue;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Pizza',
            ),
            onChanged: (newValue) {
              setState(() {
                pizzaName = newValue;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Opis',
            ),
            onChanged: (newValue) {
              setState(() {
                descriptionName = newValue;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              final data = {
                'name': restaurantName,
                'pizza': pizzaName,
                'rating': 4,
                'description': descriptionName,
              };

              FirebaseFirestore.instance.collection('restaurants').add(data);
            },
            child: const Text('Dodaj opinię'),
          ),
        ],
      ),
    );
  }
}

// final addRestaurantController = TextEditingController();
// final addPizzaController = TextEditingController();
// final addDescriptionController = TextEditingController();

// class _AddOpinionPageContentState extends State<AddOpinionPageContent> {

//   var restaurantsName = '';
//   var pizzaName = '';

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: widget.addRestaurantController,
//             decoration: const InputDecoration(
//               hintText: 'Restauracja',
//             ),
//           ),
//           TextField(
//             controller: widget.addPizzaController,
//             decoration: const InputDecoration(
//               hintText: 'Pizza',
//             ),
//           ),
//           TextField(
//             controller: widget.addDescriptionController,
//             decoration: const InputDecoration(
//               hintText: 'Opis',
//             ),
//           ),
//           SizedBox(height: 40),
//           FloatingActionButton(
//             onPressed: () {
//               final data = {
//                 'name': widget.addRestaurantController.text,
//                 'pizza': widget.addPizzaController.text,
//                 'description': widget.addDescriptionController.text,
//               };

//               FirebaseFirestore.instance.collection('restaurants').add(data);

//               widget.addRestaurantController.clear();
//               widget.addPizzaController.clear();
//               widget.addDescriptionController.clear();
//             },
//             child: Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }