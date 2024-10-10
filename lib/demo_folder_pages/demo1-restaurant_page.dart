// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:food_delivery_app/pages/cart_pages/cart1_page.dart';
// //import 'package:food_delivery_app/pages/cart_pages/cart_page.dart';
// import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
// import 'package:provider/provider.dart';
// import 'restaurant_menu_list_items.dart';

// class RestaurantPage extends StatefulWidget {
//   final String pageImage;
//   final String pageHeading;
//   final String pageSubHeading;

//   const RestaurantPage(
//       {required this.pageImage,
//       required this.pageHeading,
//       required this.pageSubHeading,
//       super.key});

//   @override
//   State<RestaurantPage> createState() => _RestaurantPageState();
// }

// class _RestaurantPageState extends State<RestaurantPage> {
//   bool isTextSelected1 = false;
//   bool isTextSelected2 = false;
//   bool isTextSelected3 = false;
//   bool isTextSelected4 = false;
//   bool isTextSelected5 = false;
//   bool isTextSelected6 = false;
//   bool isChecked1 = false;
//   bool isChecked2 = false;
//   late bool veg;
//   List<List<String>> selectedList = [];
//   late int index;
//   late CartProvider provider;

//   @override
//   void initState() {
//     setState(() {
//       isTextSelected1 = true;
//       selectedList = beefAndLamb;
//     });
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Safe to access the provider here
//     provider = Provider.of<CartProvider>(context, listen: false);
//   }

//   Widget cardItem(
//       {required String img,
//       required String heading,
//       required String subHeading,
//       required String cost,
//       required int index,
//       required String type}) {
//     return Column(
//       children: [
//         Card(
//           elevation: 1,
//           child: Container(
//             height: 136,
//             width: MediaQuery.of(context).size.width, //398,
//             decoration: const BoxDecoration(color: Colors.white),
//             child: Row(
//               children: [
//                 Container(
//                   height: 136,
//                   width: 136,
//                   decoration: BoxDecoration(
//                     color: Colors.white54,
//                     borderRadius: BorderRadius.circular(8),
//                     image: DecorationImage(
//                         image: NetworkImage(img), fit: BoxFit.cover),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               heading,
//                               style: const TextStyle(
//                                   color: Color(0xFF333333),
//                                   fontFamily: 'Merienda',
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             const Spacer(),
//                             type == 'Yes'
//                                 ? SvgPicture.asset(
//                                     'assets/svg/veg_non-veg/veg.svg')
//                                 : SvgPicture.asset(
//                                     'assets/svg/veg_non-veg/non_veg.svg')
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 3,
//                         ),
//                         Text(subHeading,
//                             style: const TextStyle(
//                               fontFamily: 'DMSans',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF999999),
//                             )),
//                         const Spacer(),
//                         SizedBox(
//                           child: Row(
//                             children: [
//                               Text('₹$cost',
//                                   style: const TextStyle(
//                                       fontFamily: 'Merienda',
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xFFFE724C))),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () => {
//                                   showCustomizationSheet(index, cost),
//                                 },
//                                 child: Container(
//                                   width: 79,
//                                   height: 32,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                         color: const Color(0xFFC0C0C0)),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       'Add',
//                                       style: TextStyle(
//                                         color: Color(0xFFFE724C),
//                                         fontFamily: 'Merienda',
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         )
//       ],
//     );
//   }

//   Future<dynamic> showCustomizationSheet(int index, String cost) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return DraggableScrollableSheet(
//           initialChildSize: 0.35,
//           maxChildSize: 0.35,
//           expand: false,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(20.0)),
//               child: Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(left: 16, right: 16),
//                 child: StatefulBuilder(
//                   builder: (BuildContext context, StateSetter setState) {
//                     return Stack(children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const Text('Combo Sandwich'),
//                           const Text(
//                             'Customize to your liking',
//                             style: TextStyle(
//                                 fontSize: 24,
//                                 fontFamily: 'Merienda',
//                                 color: Colors.black),
//                           ),
//                           const Divider(
//                             color: Color(0xFFC0C0C0),
//                             thickness: 0.5,
//                           ),
//                           const SizedBox(height: 10),
//                           const Text(
//                               'Choose Your Favourite Sandwich Bread (Optional)'),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Expanded(
//                             child: ListView(
//                               controller: scrollController,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               children: [
//                                 CustomCheckboxTile(
//                                   title: 'Wheat',
//                                   cost: '20',
//                                   value: isChecked1,
//                                   onChanged: (bool? value) {
//                                     setState(() {
//                                       isChecked1 = value ?? false;
//                                     });
//                                   },
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 CustomCheckboxTile(
//                                   title: 'Multi-Grain',
//                                   cost: '50',
//                                   value: isChecked2,
//                                   onChanged: (bool? value) {
//                                     setState(() {
//                                       isChecked2 = value ?? false;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: ElevatedButton(
//                                 style: const ButtonStyle(
//                                   side: WidgetStatePropertyAll(BorderSide(
//                                       color: Colors.grey, width: 0.5)),
//                                   backgroundColor:
//                                       WidgetStatePropertyAll(Colors.white),
//                                 ),
//                                 onPressed: () {
//                                   if (provider.cart.isNotEmpty &&
//                                       provider.cart[0][0] !=
//                                           widget.pageHeading) {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('Clear Cart?'),
//                                           content: const Text(
//                                             'Your cart contains items from another restaurant. Do you want to clear the cart and add the new item?',
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               child: const Text(
//                                                 'Cancel',
//                                                 style: TextStyle(
//                                                     color: Color(0xFFFE724C)),
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.of(context)
//                                                     .pop(); // Close the dialog
//                                               },
//                                             ),
//                                             TextButton(
//                                               child: const Text(
//                                                 'Clear Cart and Add',
//                                                 style: TextStyle(
//                                                     color: Color(0xFFFE724C)),
//                                               ),
//                                               onPressed: () {
//                                                 provider
//                                                     .reset(); // Clear the cart
//                                                 provider.add(
//                                                     restaurantName:
//                                                         widget.pageHeading,
//                                                     address:
//                                                         'McDonald’s, Cubbon Park, Hyderabad',
//                                                     itemName:
//                                                         selectedList[index][1],
//                                                     img: selectedList[index][0],
//                                                     cost: cost,
//                                                     type: selectedList[index]
//                                                         [4]);
//                                                 Navigator.of(context)
//                                                     .pop(); // Close the dialog
//                                                 Navigator.of(context)
//                                                     .pop(); // Close the customization sheet

//                                                 ScaffoldMessenger.of(context)
//                                                     .showSnackBar(
//                                                   const SnackBar(
//                                                     content: Text(
//                                                         'Item added successfully'),
//                                                     backgroundColor:
//                                                         Color(0xFFFE724C),
//                                                     duration:
//                                                         Duration(seconds: 2),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   } else {
//                                     provider.add(
//                                         restaurantName: widget.pageHeading,
//                                         address:
//                                             'McDonald’s, Cubbon Park, Hyderabad',
//                                         itemName: selectedList[index][1],
//                                         img: selectedList[index][0],
//                                         cost: cost,
//                                         type: selectedList[index][4]);
//                                     Navigator.of(context)
//                                         .pop(); // Close the customization sheet

//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content:
//                                             Text('Item added successfully'),
//                                         backgroundColor: Color(0xFFFE724C),
//                                         duration: Duration(seconds: 2),
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 child: Text(
//                                   'Add to Cart',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineSmall
//                                       ?.copyWith(
//                                           color: const Color(0xFFFE724C)),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: IconButton(
//                           icon: const Icon(Icons.close, color: Colors.black),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       )
//                     ]);
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//     final headlineMedium = Theme.of(context).textTheme.headlineMedium;
//     final titleMedium = Theme.of(context).textTheme.titleMedium;
//     final bodyMedium = Theme.of(context).textTheme.bodyMedium;
//     final titleLarge = Theme.of(context).textTheme.titleLarge;
//     final titleSmall = Theme.of(context).textTheme.titleSmall;
//     final displaySmall = Theme.of(context).textTheme.displaySmall;

//     return Scaffold(
//       body: Stack(children: [
//         SingleChildScrollView(
//           child: Container(
//             decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(children: [
//                   Image.asset(widget.pageImage),
//                   Positioned(
//                       top: 50,
//                       left: 10,
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(Icons.arrow_back_ios_new),
//                         color: const Color(0xFFFFFFFF),
//                       )),
//                 ]),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16),
//                   child: Row(
//                     children: [
//                       Text(
//                         widget.pageHeading,
//                         style: headlineMedium,
//                       ),
//                       const Spacer(),
//                       Container(
//                         height: 36,
//                         width: 94,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.green,
//                         ),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('4.5',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.bold)),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Icon(
//                               Icons.star,
//                               color: Colors.white,
//                               size: 20,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
//                   child: Text(
//                     widget.pageSubHeading,
//                     style: bodyMedium?.copyWith(color: const Color(0xFF767676)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
//                   child: Text(
//                     '₹200 for two',
//                     style: titleLarge?.copyWith(color: primaryColor),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
//                   child: Row(
//                     children: [
//                       Text(
//                         '30 min',
//                         style: bodyMedium?.copyWith(
//                             color: const Color(0xFF333333)),
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       const Icon(
//                         Icons.circle,
//                         size: 4,
//                         color: Color(0xFF767676),
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       Text(
//                         'Cubbon Park',
//                         style: bodyMedium?.copyWith(
//                             color: const Color(0xFF333333)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 16, right: 16, top: 16, bottom: 10),
//                   child: Container(
//                     height: 36,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: primaryColor),
//                     child: Row(
//                       children: [
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         SvgPicture.asset('assets/svg/icons/bookmark.svg'),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Center(
//                           child: Text(
//                             'Free delivery + Extra 10% Off on selected items',
//                             style: titleSmall?.copyWith(
//                                 color: const Color(0xFFFFFFFF)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 24, right: 24),
//                   child: Divider(
//                     thickness: 0.5,
//                     color: Color(0xFFC0C0C0),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 16, right: 16, top: 10, bottom: 20),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         hintText: 'Search your food nearby...',
//                         hintStyle: displaySmall?.copyWith(
//                             color: const Color(0xFF767676)),
//                         prefixIcon: const Icon(
//                           Icons.search,
//                           color: Color(0xFF767676),
//                         ),
//                         filled: true,
//                         fillColor: const Color(0xFFEBEBEB),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: Color(0xFFC0C0C0), width: 1),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: primaryColor),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 16,
//                     ),
//                     Container(
//                       width: 77,
//                       height: 32,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           border: Border.all(color: Colors.green)),
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             'Veg',
//                             style: titleMedium?.copyWith(color: Colors.green),
//                           ),
//                           const SizedBox(
//                             width: 6,
//                           ),
//                           SvgPicture.asset(
//                             'assets/svg/veg_non-veg/veg.svg',
//                             height: 16,
//                             width: 16,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 16,
//                     ),
//                     Container(
//                       width: 117,
//                       height: 32,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(32),
//                           border: Border.all(color: Colors.red)),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               'Non-Veg',
//                               style: titleMedium?.copyWith(color: Colors.red),
//                             ),
//                             const SizedBox(
//                               width: 6,
//                             ),
//                             SvgPicture.asset(
//                               'assets/svg/veg_non-veg/non_veg.svg',
//                               height: 16,
//                               width: 16,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16),
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.only(left: 16, right: 16),
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isTextSelected2 = isTextSelected3 =
//                                   isTextSelected4 =
//                                       isTextSelected5 = isTextSelected6 = false;
//                               isTextSelected1 = !isTextSelected1;
//                               selectedList = beefAndLamb;
//                             });
//                           },
//                           child: Text(
//                             'Beef & Lamb',
//                             style: titleMedium?.copyWith(
//                                 color: isTextSelected1
//                                     ? const Color(0xFF333333)
//                                     : const Color(0xFFA1A1A1)),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isTextSelected1 = isTextSelected3 =
//                                   isTextSelected4 =
//                                       isTextSelected5 = isTextSelected6 = false;
//                               isTextSelected2 = true;
//                               selectedList = seaFood;
//                             });
//                           },
//                           child: Text(
//                             'Seafood',
//                             style: titleMedium?.copyWith(
//                                 color: isTextSelected2
//                                     ? const Color(0xFF333333)
//                                     : const Color(0xFFA1A1A1)),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isTextSelected1 = isTextSelected2 =
//                                   isTextSelected4 =
//                                       isTextSelected5 = isTextSelected6 = false;
//                               isTextSelected3 = true;
//                               selectedList = appetizers;
//                             });
//                           },
//                           child: Text(
//                             'Appetizers',
//                             style: titleMedium?.copyWith(
//                                 color: isTextSelected3
//                                     ? const Color(0xFF333333)
//                                     : const Color(0xFFA1A1A1)),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isTextSelected1 = isTextSelected2 =
//                                   isTextSelected3 =
//                                       isTextSelected5 = isTextSelected6 = false;
//                               isTextSelected4 = true;
//                               selectedList = dimSum;
//                             });
//                           },
//                           child: Text(
//                             'Dim Sum',
//                             style: titleMedium?.copyWith(
//                                 color: isTextSelected4
//                                     ? const Color(0xFF333333)
//                                     : const Color(0xFFA1A1A1)),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isTextSelected1 = isTextSelected2 =
//                                   isTextSelected3 =
//                                       isTextSelected4 = isTextSelected6 = false;
//                               isTextSelected5 = true;
//                               selectedList = soups;
//                             });
//                           },
//                           child: Text(
//                             'Soups',
//                             style: titleMedium?.copyWith(
//                                 color: isTextSelected5
//                                     ? const Color(0xFF333333)
//                                     : const Color(0xFFA1A1A1)),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isTextSelected1 = isTextSelected2 =
//                                   isTextSelected3 =
//                                       isTextSelected4 = isTextSelected5 = false;
//                               isTextSelected6 = true;
//                               selectedList = curries;
//                             });
//                           },
//                           child: Text(
//                             'Curries',
//                             style: titleMedium?.copyWith(
//                                 color: isTextSelected6
//                                     ? const Color(0xFF333333)
//                                     : const Color(0xFFA1A1A1)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16),
//                   child: ListView.builder(
//                       itemCount: selectedList.length,
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.only(bottom: 40),
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return cardItem(
//                             img: selectedList[index][0],
//                             heading: selectedList[index][1],
//                             subHeading: selectedList[index][2],
//                             cost: selectedList[index][3],
//                             index: index,
//                             type: selectedList[index][4]);
//                       }),
//                 ),
//                 Consumer<CartProvider>(
//                   builder: (context, provider, child) {
//                     return provider.cart.isNotEmpty
//                         ? const SizedBox(
//                             height: 90,
//                           )
//                         : const SizedBox();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//         Consumer<CartProvider>(builder: (context, provider, child) {
//           return provider.cart.isNotEmpty
//               ? Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         borderRadius:
//                             BorderRadius.only(topLeft: Radius.circular(12)),
//                         color: Colors.white),
//                     height: 130,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(12)),
//                             color: Color(0xFFFEA187),
//                           ),
//                           height: 57,
//                           width: double.infinity,
//                           child: Center(
//                             child: Text(
//                               'You’re saving ${provider.coupon} on this order',
//                               style: const TextStyle(
//                                 fontFamily: 'Merienda',
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF000000),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Spacer(
//                               flex: 1,
//                             ),
//                             Text(
//                               '${provider.cart.length.toString()} ${provider.cart.length > 1 ? 'items' : 'item'}',
//                               style: titleSmall?.copyWith(fontSize: 14),
//                             ),
//                             const Text('-'),
//                             Text(
//                               '₹ ${provider.totalCost().toStringAsFixed(0)}',
//                               style: titleSmall?.copyWith(fontSize: 14),
//                             ),
//                             const Spacer(
//                               flex: 2,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const Cart1Page()),
//                                 );
//                               },
//                               child: Container(
//                                 height: 30,
//                                 width: 120,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(14),
//                                     border: Border.all(
//                                         color: const Color(0xFFC0C0C0))),
//                                 child: Center(
//                                   child: Text(
//                                     'View Cart',
//                                     style: titleSmall?.copyWith(
//                                         color: primaryColor),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const Spacer(
//                               flex: 1,
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ))
//               : Container();
//         }),
//       ]),
//     );
//   }
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
