
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:food_delivery_app/models/restaurant.dart';
// import 'package:food_delivery_app/pages/category_pages/category/restaurant_page.dart';
// import 'package:food_delivery_app/pages/search_page/search_page.dart';
// import 'package:food_delivery_app/pages/widgets/widgets_category_page.dart';

// class CategoryPage extends StatefulWidget {
//   const CategoryPage({super.key});

//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<CategoryPage> {
//   List<String> searchList = [
//     'food',
//     'dish',
//     'restaurant',
//     'ice cream',
//     'cuisine',
//     'meal',
//   ];
//   int index = 0;

//   @override
//   void initState() {
//     super.initState();
//     _startTextAnimation();
//   }

//   void _startTextAnimation() {
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         index = (index + 1) % searchList.length;
//       });
//       _startTextAnimation(); // Repeat the animation for the next text
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final indicatorColor = Theme.of(context).indicatorColor;
//     final shadowColor = Theme.of(context).shadowColor;
//     final bodyMedium = Theme.of(context).textTheme.bodyMedium;
//     final TextTheme theme = Theme.of(context).textTheme;

//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             scrolledUnderElevation: 0,
//           ),
//           backgroundColor: Colors.white,
//           body: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("restaurants")
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 }
//                 if (snapshot.data == null) {
//                   return const Text('Something went wrong');
//                 }
//                 List<Restaurant> restaurants = (snapshot.data?.docs ?? [])
//                     .map((doc) =>
//                         Restaurant.fromMap(doc as Map<String, dynamic>))
//                     .toList();

//                 return Column(
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16, right: 16),
//                       child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const SearchPage()));
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                                 color: const Color(0xFFEBEBEB),
//                                 border: Border.all(color: indicatorColor),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.search_rounded,
//                                   color: Color(0xFF767676),
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text('Search for ',
//                                     style: theme.displaySmall?.copyWith(
//                                         color: const Color(0xFF767676))),
//                                 Expanded(
//                                   child: TweenAnimationBuilder(
//                                     key: ValueKey<int>(index),
//                                     tween: Tween<Offset>(
//                                       begin: const Offset(0, 0.2),
//                                       end: const Offset(0, 0),
//                                     ), // Drop from top
//                                     duration: const Duration(milliseconds: 300),
//                                     builder: (context, Offset offset, child) {
//                                       return FractionalTranslation(
//                                         translation: offset,
//                                         child: child,
//                                       );
//                                     },
//                                     child: Text('"${searchList[index]}"',
//                                         style: theme.displaySmall?.copyWith(
//                                             color: const Color(0xFF767676))),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16, right: 16),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               color: shadowColor,
//                               thickness: 1,
//                             ),
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               'Powered by ONDC',
//                               style: bodyMedium?.copyWith(
//                                   color: const Color(0xFF767676)),
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               color: shadowColor,
//                               thickness: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     SizedBox(
//                         child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           itemSpace(
//                               img: 'assets/images/Items-list/image1.png',
//                               name: 'Daily Meals'),
//                           itemSpace(
//                               img: 'assets/images/Items-list/image2.png',
//                               name: 'Biryani'),
//                           itemSpace(
//                               img: 'assets/images/Items-list/image3.png',
//                               name: 'Chinese'),
//                           itemSpace(
//                               img: 'assets/images/Items-list/image4.png',
//                               name: 'Desi'),
//                           itemSpace(
//                               img: 'assets/images/Items-list/image5.png',
//                               name: 'Deshi'),
//                         ],
//                       ),
//                     )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.vertical,
//                         child: Column(
//                           children: [
//                             Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 RestaurantPage(
//                                                   pageImage:
//                                                       restaurants[0].banner,
//                                                   pageHeading:
//                                                       restaurants[0].name,
//                                                   pageSubHeading:
//                                                       restaurants[0].subHeading,
//                                                 )));
//                                   },
//                                   child:
//                                       Stack(clipBehavior: Clip.none, children: [
//                                     cardItem(
//                                         context: context,
//                                         img: restaurants[0].banner,
//                                         heading: restaurants[0].name,
//                                         subHeading: restaurants[0].subHeading),
//                                     Positioned(
//                                         top: 25,
//                                         left: -2,
//                                         child: SvgPicture.asset(
//                                             'assets/svg/bookmark/rescued.svg')),
//                                     Positioned(
//                                         top: 60,
//                                         left: -2,
//                                         child: SvgPicture.asset(
//                                             'assets/svg/bookmark/fifty_off.svg'))
//                                   ]),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 RestaurantPage(
//                                                   pageImage:
//                                                       restaurants[1].banner,
//                                                   pageHeading:
//                                                       restaurants[1].name,
//                                                   pageSubHeading:
//                                                       restaurants[1].subHeading,
//                                                 )));
//                                   },
//                                   child: Stack(children: [
//                                     cardItem(
//                                         context: context,
//                                         img: restaurants[1].banner,
//                                         heading: restaurants[1].name,
//                                         subHeading: restaurants[1].subHeading),
//                                     Positioned(
//                                         top: 25,
//                                         left: -2,
//                                         child: SvgPicture.asset(
//                                             'assets/svg/bookmark/twenty_off.svg')),
//                                   ]),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 RestaurantPage(
//                                                   pageImage:
//                                                       restaurants[2].banner,
//                                                   pageHeading:
//                                                       restaurants[2].name,
//                                                   pageSubHeading:
//                                                       restaurants[2].subHeading,
//                                                 )));
//                                   },
//                                   child: Stack(children: [
//                                     cardItem(
//                                         context: context,
//                                         img: restaurants[2].banner,
//                                         heading: restaurants[2].name,
//                                         subHeading: restaurants[2].subHeading),
//                                   ]),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 RestaurantPage(
//                                                   pageImage:
//                                                       restaurants[3].banner,
//                                                   pageHeading:
//                                                       restaurants[3].name,
//                                                   pageSubHeading:
//                                                       restaurants[3].subHeading,
//                                                 )));
//                                   },
//                                   child: Stack(children: [
//                                     cardItem(
//                                         context: context,
//                                         img: restaurants[3].banner,
//                                         heading: restaurants[3].name,
//                                         subHeading: restaurants[3].subHeading),
//                                     Positioned(
//                                         top: 25,
//                                         left: -2,
//                                         child: SvgPicture.asset(
//                                             'assets/svg/bookmark/fifty_off.svg')),
//                                   ]),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 RestaurantPage(
//                                                   pageImage:
//                                                       restaurants[4].banner,
//                                                   pageHeading:
//                                                       restaurants[4].name,
//                                                   pageSubHeading:
//                                                       restaurants[4].subHeading,
//                                                 )));
//                                   },
//                                   child: Stack(children: [
//                                     cardItem(
//                                         context: context,
//                                         img: restaurants[4].banner,
//                                         heading: restaurants[4].name,
//                                         subHeading: restaurants[4].subHeading),
//                                     Positioned(
//                                         top: 25,
//                                         left: -2,
//                                         child: SvgPicture.asset(
//                                             'assets/svg/bookmark/twenty_off.svg')),
//                                   ]),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 70,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               })),
//     );
//   }
// }
