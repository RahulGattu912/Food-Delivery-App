import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/navigation_page/navigation_page.dart';
import 'package:food_delivery_app/pages/order_pages/dashed_divider.dart';
import 'package:food_delivery_app/pages/order_pages/order_details.dart';
import 'package:food_delivery_app/pages/order_pages/tracking_order/track_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Orders Yet!',
                style:
                    theme.bodyLarge?.copyWith(color: colorTheme.primaryColor),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docSnapshot = snapshot.data;
          if (docSnapshot == null || !docSnapshot.exists) {
            return Center(
              child: Text(
                'No Orders Yet!',
                style:
                    theme.bodyLarge?.copyWith(color: colorTheme.primaryColor),
              ),
            );
          }

          List<Map<String, dynamic>> orders = List<Map<String, dynamic>>.from(
              docSnapshot.data()?['items'] ?? []);

          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No Orders Yet!',
                style:
                    theme.bodyLarge?.copyWith(color: colorTheme.primaryColor),
              ),
            );
          }

          String orderItems = "";
          double totalCost = 0.0;

          for (var item in orders) {
            orderItems += item['name'];
            String temp =
                item['count'] > 1 ? ' (x${item['count'].toString()}), ' : ', ';
            orderItems += temp;
            double itemCost = double.parse(item['cost']);
            totalCost += itemCost * item['count'];
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationPage(
                                  initialIndex: 0,
                                )),
                        (Route<dynamic> route) => false);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
              title: const Text('My Orders'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 290,
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 3,
                      shadowColor: const Color(0xFF333333),
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  orders[0]['restaurant'],
                                  style:
                                      theme.titleLarge?.copyWith(fontSize: 16),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFFD0BCFF)),
                                  child: Center(
                                    child: Text(
                                      'Shipping',
                                      style: theme.titleMedium
                                          ?.copyWith(fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NSP',
                                  style: theme.labelMedium?.copyWith(
                                      color: const Color(0xFF767676),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹${totalCost.toStringAsFixed(2)}',
                                  style: theme.titleMedium?.copyWith(
                                      color: colorTheme.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const DashedDivider(),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  orderItems,
                                  style:
                                      const TextStyle(color: Color(0xFF333333)),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '17/11/2024, 04:20',
                                  style: theme.labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrderDetails()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 37,
                                        right: 37,
                                        top: 12,
                                        bottom: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: colorTheme.indicatorColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                      'Order Details',
                                      style: theme.titleSmall?.copyWith(
                                          color: colorTheme.primaryColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TrackOrder()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 37,
                                        right: 37,
                                        top: 12,
                                        bottom: 12),
                                    decoration: BoxDecoration(
                                        color: colorTheme.primaryColor,
                                        border: Border.all(
                                            color: colorTheme.indicatorColor),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(
                                        'Track Order',
                                        style: theme.titleSmall?.copyWith(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// class OrderPage extends StatefulWidget {
//   const OrderPage({super.key});

//   @override
//   State<OrderPage> createState() => _OrderPageState();
// }

// class _OrderPageState extends State<OrderPage> {
//   @override
//   Widget build(BuildContext context) {
//     final TextTheme theme = Theme.of(context).textTheme;
//     final ThemeData colorTheme = Theme.of(context);
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('orders').snapshots(),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (!snapshot.hasData) {
//             return Text(
//               'No Orders Yet!',
//               style: theme.bodyLarge?.copyWith(color: colorTheme.primaryColor),
//             );
//           }
//           late List<Map<String, dynamic>> orders = [];
//           final String uid = FirebaseAuth.instance.currentUser!.uid;
//           FirebaseFirestore.instance
//               .collection('orders')
//               .doc(uid)
//               .get()
//               .then((DocumentSnapshot<Map<String, dynamic>> docSnapshot) {
//             if (docSnapshot.exists) {
//               orders = List<Map<String, dynamic>>.from(
//                   docSnapshot.data()?['items'] ?? []);

//               debugPrint(orders.toString());
//             } else {
//               debugPrint('No orders found for user: $uid');
//             }
//           }).catchError((error) {
//             debugPrint('Error fetching order: $error');
//           });
//           String orderItems = "";

//           for (var item in orders) {
//             orderItems += item['name'];
//             String temp =
//                 item['count'] > 1 ? '{x${item['count'].toString()}},' : ',';
//             orderItems += temp;
//           }
//           double totalCost = 0.0;
//           for (int i = 0; i < orders.length; i++) {
//             double itemCost = double.parse(orders[i]['cost']);
//             int itemCount = orders[i]['count'];
//             totalCost += itemCost * itemCount;
//           }
//           return orders.isEmpty
//               ? Text(
//                   'No Orders Yet!',
//                   style:
//                       theme.bodyLarge?.copyWith(color: colorTheme.primaryColor),
//                 )
//               : Scaffold(
//                   backgroundColor: Colors.white,
//                   appBar: AppBar(
//                     scrolledUnderElevation: 0,
//                     backgroundColor: Colors.white,
//                     leading: IconButton(
//                         onPressed: () {
//                           Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const NavigationPage()),
//                               (Route<dynamic> route) => false);
//                         },
//                         icon: const Icon(Icons.arrow_back_ios_new)),
//                     title: const Text('My Orders'),
//                   ),
//                   body: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Container(
//                             height: 290,
//                             padding: const EdgeInsets.all(16),
//                             child: Card(
//                               margin: EdgeInsets.zero,
//                               elevation: 3,
//                               shadowColor: const Color(0xFF333333),
//                               color: Colors.white,
//                               surfaceTintColor: Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           orders[0]['restaurant'],
//                                           style: theme.titleLarge
//                                               ?.copyWith(fontSize: 16),
//                                         ),
//                                         const Spacer(),
//                                         Container(
//                                           padding: const EdgeInsets.only(
//                                               left: 16,
//                                               right: 16,
//                                               top: 8,
//                                               bottom: 8),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color: const Color(0xFFD0BCFF)),
//                                           child: Center(
//                                             child: Text(
//                                               'Shipping',
//                                               style: theme.titleMedium
//                                                   ?.copyWith(fontSize: 12),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'NSP',
//                                           style: theme.labelMedium?.copyWith(
//                                               color: const Color(0xFF767676),
//                                               fontSize: 14),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '₹${totalCost.toStringAsFixed(2)}',
//                                           style: theme.titleMedium?.copyWith(
//                                               color: colorTheme.primaryColor,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     const DashedDivider(),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           orderItems,
//                                           style: const TextStyle(
//                                               color: Color(0xFF333333)),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '17/11/2024, 04:20',
//                                           style: theme.labelSmall,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const OrderDetails()));
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.only(
//                                                 left: 37,
//                                                 right: 37,
//                                                 top: 12,
//                                                 bottom: 12),
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: colorTheme
//                                                         .indicatorColor),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12)),
//                                             child: Text(
//                                               'Order Details',
//                                               style: theme.titleSmall?.copyWith(
//                                                   color:
//                                                       colorTheme.primaryColor,
//                                                   fontSize: 14),
//                                             ),
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const TrackOrder()));
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.only(
//                                                 left: 37,
//                                                 right: 37,
//                                                 top: 12,
//                                                 bottom: 12),
//                                             decoration: BoxDecoration(
//                                                 color: colorTheme.primaryColor,
//                                                 border: Border.all(
//                                                     color: colorTheme
//                                                         .indicatorColor),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12)),
//                                             child: Center(
//                                               child: Text(
//                                                 'Track Order',
//                                                 style: theme.titleSmall
//                                                     ?.copyWith(
//                                                         color: Colors.white,
//                                                         fontSize: 14),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )),
//                         Container(
//                             height: 290,
//                             padding: const EdgeInsets.all(16),
//                             child: Card(
//                               margin: EdgeInsets.zero,
//                               elevation: 3,
//                               shadowColor: const Color(0xFF333333),
//                               color: Colors.white,
//                               surfaceTintColor: Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'The Cubano Sandwich Co.',
//                                           style: theme.titleLarge
//                                               ?.copyWith(fontSize: 16),
//                                         ),
//                                         const Spacer(),
//                                         Container(
//                                           padding: const EdgeInsets.only(
//                                               left: 16,
//                                               right: 16,
//                                               top: 8,
//                                               bottom: 8),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color: const Color(0xFFACEECE)),
//                                           child: Center(
//                                             child: Text(
//                                               'Delivered',
//                                               style: theme.titleMedium
//                                                   ?.copyWith(fontSize: 12),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'HSR Layout',
//                                           style: theme.labelMedium?.copyWith(
//                                               color: const Color(0xFF767676),
//                                               fontSize: 14),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '₹28.90',
//                                           style: theme.titleMedium?.copyWith(
//                                               color: colorTheme.primaryColor,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     const DashedDivider(),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     const Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '[veg] Grilled Veggie Parmesan Cubano Sandwich (x1),\nBlue Lemonade (x1)',
//                                           style: TextStyle(
//                                               color: Color(0xFF333333)),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           '17/04/2024, 04:20',
//                                           style: theme.labelSmall,
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.only(
//                                               left: 50,
//                                               right: 50,
//                                               top: 12,
//                                               bottom: 12),
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: colorTheme
//                                                       .indicatorColor),
//                                               borderRadius:
//                                                   BorderRadius.circular(12)),
//                                           child: Text(
//                                             'Re-Order',
//                                             style: theme.titleSmall?.copyWith(
//                                                 color: colorTheme.primaryColor,
//                                                 fontSize: 14),
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const TrackOrder()));
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.only(
//                                                 left: 42,
//                                                 right: 42,
//                                                 top: 12,
//                                                 bottom: 12),
//                                             decoration: BoxDecoration(
//                                                 // color: colorTheme.primaryColor,
//                                                 border: Border.all(
//                                                     color: const Color(
//                                                         0xFF5C5C5C)),
//                                                 borderRadius:
//                                                     BorderRadius.circular(12)),
//                                             child: Center(
//                                               child: Text(
//                                                 'Rate Order',
//                                                 style: theme.titleSmall
//                                                     ?.copyWith(
//                                                         color: const Color(
//                                                             0xFF767676),
//                                                         fontSize: 14),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )),
//                       ],
//                     ),
//                   ),
//                 );
//         });
//   }
// }
