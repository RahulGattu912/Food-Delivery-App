// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
// import 'package:provider/provider.dart';

// Widget cardItem(
//     {required String img,
//     required String heading,
//     required String subHeading,
//     required String cost,
//     required int index}) {
//        var provider = Provider.of<CartProvider>(BuildContext context, listen: false);
//   return Card(
//     elevation: 2,
//     child: Container(
//       height: 136,
//       width: 398,
//       decoration: const BoxDecoration(color: Colors.white),
//       child: Row(
//         children: [
//           Container(
//             height: 136,
//             width: 136,
//             decoration: BoxDecoration(
//               color: Colors.white54,
//               borderRadius: BorderRadius.circular(8),
//               image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   heading,
//                   style: const TextStyle(
//                       color: Color(0xFF333333),
//                       fontFamily: 'Merienda',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 3,
//                 ),
//                 Text(subHeading,
//                     style: const TextStyle(
//                       fontFamily: 'DMSans',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xFF999999),
//                     )),
//                 const Spacer(),
//                 SizedBox(
//                   child: Row(
//                     children: [
//                       Text('₹$cost',
//                           style: const TextStyle(
//                               fontFamily: 'Merienda',
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFFFE724C))),
//                       const SizedBox(
//                         width: 80,
//                       ),
//                       GestureDetector(
//                         onTap: () => {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (BuildContext context) {
//                               return DraggableScrollableSheet(
//                                 initialChildSize: 0.35,
//                                 maxChildSize: 0.35,
//                                 expand: false,
//                                 builder: (BuildContext context,
//                                     ScrollController scrollController) {
//                                   return ClipRRect(
//                                     borderRadius: const BorderRadius.vertical(
//                                         top: Radius.circular(20.0)),
//                                     child: Container(
//                                       color: Colors.white,
//                                       padding: const EdgeInsets.only(
//                                           left: 16, right: 16),
//                                       child: StatefulBuilder(
//                                         builder: (BuildContext context,
//                                             StateSetter setState) {
//                                           return Stack(children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const SizedBox(
//                                                   height: 20,
//                                                 ),
//                                                 const Text('Combo Sandwich'),
//                                                 const Text(
//                                                   'Customize to your liking',
//                                                   style: TextStyle(
//                                                       fontSize: 24,
//                                                       fontFamily: 'Merienda',
//                                                       color: Colors.black),
//                                                 ),
//                                                 const Divider(
//                                                   color: Color(0xFFC0C0C0),
//                                                   thickness: 0.5,
//                                                 ),
//                                                 const SizedBox(height: 10),
//                                                 const Text(
//                                                     'Choose Your Favourite Sandwich Bread (Optional)'),
//                                                 const SizedBox(
//                                                   height: 8,
//                                                 ),
//                                                 Expanded(
//                                                   child: ListView(
//                                                     controller:
//                                                         scrollController,
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                         horizontal: 16),
//                                                     children: [
//                                                       CustomCheckboxTile(
//                                                         title: 'Wheat',
//                                                         cost: '20',
//                                                         value: isChecked1,
//                                                         onChanged:
//                                                             (bool? value) {
//                                                           setState(() {
//                                                             isChecked1 =
//                                                                 value ?? false;
//                                                           });
//                                                         },
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       CustomCheckboxTile(
//                                                         title: 'Multi-Grain',
//                                                         cost: '50',
//                                                         value: isChecked2,
//                                                         onChanged:
//                                                             (bool? value) {
//                                                           setState(() {
//                                                             isChecked2 =
//                                                                 value ?? false;
//                                                           });
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Center(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             16.0),
//                                                     child: ElevatedButton(
//                                                       style: const ButtonStyle(
//                                                         side:
//                                                             WidgetStatePropertyAll(
//                                                                 BorderSide(
//                                                                     color: Colors
//                                                                         .grey,
//                                                                     width:
//                                                                         0.5)),
//                                                         backgroundColor:
//                                                             WidgetStatePropertyAll(
//                                                                 Colors.white),
//                                                       ),
//                                                       onPressed: () {
//                                                         provider.add(
//                                                           restaurantName: widget
//                                                               .pageHeading,
//                                                           address:
//                                                               'McDonald’s, Cubbon Park, Hyderabad',
//                                                           itemName:
//                                                               selectedList[
//                                                                   index][1],
//                                                           img: selectedList[
//                                                               index][0],
//                                                           cost: cost,
//                                                         );
//                                                         Navigator.of(context)
//                                                             .pop();

//                                                         ScaffoldMessenger.of(
//                                                                 context)
//                                                             .showSnackBar(
//                                                           const SnackBar(
//                                                             content: Text(
//                                                                 'Item added successfully'),
//                                                             backgroundColor:
//                                                                 Color(
//                                                                     0xFFFE724C),
//                                                             duration: Duration(
//                                                                 seconds: 2),
//                                                           ),
//                                                         );
//                                                       },
//                                                       child: Text(
//                                                         'Add to Cart',
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .headlineSmall
//                                                             ?.copyWith(
//                                                                 color: const Color(
//                                                                     0xFFFE724C)),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Positioned(
//                                               top: 0,
//                                               right: 0,
//                                               child: IconButton(
//                                                 icon: const Icon(Icons.close,
//                                                     color: Colors.black),
//                                                 onPressed: () {
//                                                   // Handle the close action
//                                                   Navigator.of(context)
//                                                       .pop(); // Example action: close the sheet
//                                                 },
//                                               ),
//                                             )
//                                           ]);
//                                         },
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         },
//                         child: Container(
//                           width: 79,
//                           height: 32,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: const Color(0xFFC0C0C0)),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Add',
//                               style: TextStyle(
//                                 color: Color(0xFFFE724C),
//                                 fontFamily: 'Merienda',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// class CustomCheckboxTile extends StatelessWidget {
//   final String title;
//   final String cost;
//   final bool value;
//   final ValueChanged<bool?> onChanged;

//   const CustomCheckboxTile({
//     required this.title,
//     required this.cost,
//     required this.value,
//     required this.onChanged,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Row(
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontFamily: 'Merienda',
//                   fontSize: 16,
//                   color: Color(0xFF000000),
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 '₹$cost',
//                 style: const TextStyle(
//                   fontFamily: 'Merienda',
//                   fontSize: 16,
//                   color: Color(0xFF000000),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         SizedBox(
//           width: 24,
//           height: 24,
//           child: Checkbox(
//             value: value,
//             onChanged: onChanged,
//             activeColor: const Color(0xFFFE724C),
//           ),
//         ),
//       ],
//     );
//   }
// }
