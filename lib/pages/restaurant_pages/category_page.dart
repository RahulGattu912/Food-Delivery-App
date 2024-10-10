import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/pages/restaurant_pages/restaurant_page.dart';
import 'package:food_delivery_app/pages/search_page/search_page.dart';
import 'package:food_delivery_app/pages/widgets/widgets_category_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Stream<QuerySnapshot> restaurantStream;
  List<String> searchList = [
    'food',
    'dish',
    'restaurant',
    'ice cream',
    'cuisine',
    'meal',
  ];
  int index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTextAnimation();
    restaurantStream =
        FirebaseFirestore.instance.collection("restaurants").snapshots();
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Cancel the timer when the widget is disposed to avoid memory leaks
    super.dispose();
  }

  void _startTextAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        index = (index + 1) % searchList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final indicatorColor = Theme.of(context).indicatorColor;
    final shadowColor = Theme.of(context).shadowColor;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final TextTheme theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: restaurantStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Something went wrong'));
            }

            List<Restaurant> restaurants = snapshot.data!.docs
                .map((doc) => Restaurant.fromMap(
                    doc.data() as Map<String, dynamic>, doc.id))
                .toList();

            return Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEBEB),
                        border: Border.all(color: indicatorColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF767676),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search for ',
                            style: theme.displaySmall
                                ?.copyWith(color: const Color(0xFF767676)),
                          ),
                          Expanded(
                            child: TweenAnimationBuilder(
                              key: ValueKey<int>(index),
                              tween: Tween<Offset>(
                                begin: const Offset(0, 0.2),
                                end: const Offset(0, 0),
                              ),
                              duration: const Duration(milliseconds: 300),
                              builder: (context, Offset offset, child) {
                                return FractionalTranslation(
                                  translation: offset,
                                  child: child,
                                );
                              },
                              child: Text(
                                '"${searchList[index]}"',
                                style: theme.displaySmall
                                    ?.copyWith(color: const Color(0xFF767676)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Divider and ONDC text
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: shadowColor,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Powered by ONDC',
                          style: bodyMedium?.copyWith(
                              color: const Color(0xFF767676)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: shadowColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Restaurant list
                Expanded(
                  child: ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      Restaurant restaurant = restaurants[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantPage(
                                  restaurantID: restaurant.id,
                                  pageImage: restaurant.banner,
                                  pageHeading: restaurant.name,
                                  pageSubHeading: restaurant.subHeading,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              cardItem(
                                context: context,
                                img: restaurant.banner,
                                heading: restaurant.name,
                                subHeading: restaurant.subHeading,
                              ),
                              Positioned(
                                top: 25,
                                left: -2,
                                child: SvgPicture.asset(
                                    'assets/svg/bookmark/rescued.svg'),
                              ),
                              Positioned(
                                top: 60,
                                left: -2,
                                child: SvgPicture.asset(
                                    'assets/svg/bookmark/fifty_off.svg'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
