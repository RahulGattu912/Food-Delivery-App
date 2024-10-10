// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/models/restaurant.dart';

// class DemoRetrieveData extends StatefulWidget {
//   const DemoRetrieveData({super.key});

//   @override
//   State<DemoRetrieveData> createState() => _DemoRetrieveDataState();
// }

// class _DemoRetrieveDataState extends State<DemoRetrieveData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream:
//             FirebaseFirestore.instance.collection("restaurants").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return const Text('Something went wrong');
//           }

//           List<Restaurant> restaurants = (snapshot.data?.docs ?? [])
//               .map((doc) => Restaurant.fromMap(doc.data()))
//               .toList();

//           return ListView.builder(
//             itemCount: restaurants.length,
//             itemBuilder: (context, index) {
//               final restaurant = restaurants[index];
//               return ListTile(
//                 title: Text(restaurant.name),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Address: ${restaurant.address}'),
//                     Text('Banner: ${restaurant.banner}'),
//                     Text('Items: ${restaurant.items}'),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
