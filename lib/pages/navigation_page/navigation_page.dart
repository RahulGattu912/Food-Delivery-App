import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_page.dart';
import 'package:food_delivery_app/pages/restaurant_pages/category_page.dart';
import 'package:food_delivery_app/pages/homepage/home_page.dart';
import 'package:food_delivery_app/pages/order_pages/order_page.dart';
import 'package:food_delivery_app/pages/profile_pages/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrderPage(),
    const CategoryPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFE7B55),
                Color(0xFFFD9D7A),
              ]),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFE724C)
                  .withOpacity(0.5), // Custom shadow color
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5), // Adjust shadow position
            ),
          ],
        ),
        child: FloatingActionButton(
          splashColor: primaryColor,
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: SvgPicture.asset('assets/svg/icons/shop.svg'),
          onPressed: () {
            setState(() {
              _currentIndex = 2;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          _pages[_currentIndex], // Display the current page
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(
              currentIndex: _currentIndex,
              onTabTapped: (index) {
                setState(() {
                  _currentIndex = index; // Update the current index
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const CustomNavigationBar({
    required this.currentIndex,
    required this.onTabTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final titleSmall = Theme.of(context).textTheme.titleSmall;
    return ClipPath(
      clipper: ArcClipper(),
      child: Container(
        color: Colors
            .white, // To make navigation bar transparent, change color to Colors.white70
        height: 90,
        child: Stack(
          children: [
            Positioned(
              top: 40, // Position at the bottom of the container
              left: 20,
              child: GestureDetector(
                onTap: () {
                  onTabTapped(0);
                },
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                            currentIndex == 0
                                ? primaryColor
                                : const Color(0xFFA1A1A1),
                            BlendMode.srcIn)),
                    Text(
                      'Home',
                      style: titleSmall?.copyWith(
                          color: currentIndex == 0
                              ? primaryColor
                              : const Color(0xFFA1A1A1),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 42, // Position at the bottom of the container
              left: 100,
              child: GestureDetector(
                onTap: () {
                  onTabTapped(1);
                },
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/icons/orders.svg',
                        colorFilter: ColorFilter.mode(
                            currentIndex == 1
                                ? primaryColor
                                : const Color(0xFFA1A1A1),
                            BlendMode.srcIn)),
                    Text(
                      'Orders',
                      style: titleSmall?.copyWith(
                          color: currentIndex == 1
                              ? primaryColor
                              : const Color(0xFFA1A1A1),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 42, // Position at the bottom of the container
              right: 100,
              child: GestureDetector(
                onTap: () {
                  onTabTapped(3);
                },
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/icons/cart.svg',
                        colorFilter: ColorFilter.mode(
                            currentIndex == 3
                                ? primaryColor
                                : const Color(0xFFA1A1A1),
                            BlendMode.srcIn)),
                    Text(
                      'Cart',
                      style: titleSmall?.copyWith(
                          color: currentIndex == 3
                              ? primaryColor
                              : const Color(0xFFA1A1A1),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40, // Position at the bottom of the container
              right: 20,
              child: GestureDetector(
                onTap: () {
                  onTabTapped(4);
                },
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/icons/profile.svg',
                        colorFilter: ColorFilter.mode(
                            currentIndex == 4
                                ? primaryColor
                                : const Color(0xFFA1A1A1),
                            BlendMode.srcIn)),
                    Text(
                      'Profile',
                      style: titleSmall?.copyWith(
                          color: currentIndex == 4
                              ? primaryColor
                              : const Color(0xFFA1A1A1),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 20); // Move down from the top-left corner
    path.quadraticBezierTo(
        size.width / 2, 50, size.width, 20); // Create the arc
    path.lineTo(size.width, size.height); // Draw to the bottom-right corner
    path.lineTo(0, size.height); // Draw to the bottom-left corner
    path.close(); // Close the path to complete the shape
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
