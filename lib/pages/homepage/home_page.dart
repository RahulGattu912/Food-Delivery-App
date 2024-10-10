//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/address/address.dart';
import 'package:food_delivery_app/pages/restaurant_pages/category_page.dart';
import 'package:food_delivery_app/pages/geolocation/geo_location.dart';
import 'package:food_delivery_app/pages/order_pages/order_page.dart';
import 'package:food_delivery_app/pages/search_page/search_page.dart';
import 'package:food_delivery_app/pages/widgets/widgets_cart_page.dart';
import 'package:food_delivery_app/pages/widgets/widgets_homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final LocationService _locationService = LocationService();
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);
  Timer? _timer;
  final List<String> _cardTitles = [
    'assets/images/adspace/ad1.png',
    'assets/images/adspace/ad2.png',
    'assets/images/adspace/ad1.png',
    'assets/images/adspace/ad2.png',
  ];
  List<String> searchList = [
    'food',
    'dish',
    'restaurant',
    'ice cream',
    'cuisine',
    'meal',
  ];
  String _address = "";
  bool _isLoading = true;
  int index = 0;
  final PageController _pageController2 = PageController();
  int _currentIndex2 = 0;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocationServices();
    _startAutoScroll();
    _startTextAnimation();
  }

  void _startTextAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        index = (index + 1) % searchList.length;
      });
      _startTextAnimation(); // Repeat the animation for the next text
    });
  }

  Future<void> _checkLocationServices() async {
    bool serviceEnabled = await _locationService.checkLocationServicesEnabled();

    if (serviceEnabled) {
      bool permissionGranted =
          await _locationService.checkLocationPermissions();
      if (permissionGranted) {
        _fetchAddress();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      _showLocationAlert();
    }
  }

  void _fetchAddress() async {
    String locationMessage =
        await _locationService.getLocationMessage('Home', currentUser!.uid);
    if (mounted) {
      setState(() {
        _address = locationMessage;
        _isLoading = false;
      });
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _cardTitles.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkLocationServices(); // Refresh the page when the app comes back into view
    }
  }

  void _showLocationAlert() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Services Required'),
          content: const Text(
            'For a better experience, your device will need to use Location Accuracy. Please enable it in your device settings.',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Color(0xFFFE724C)),
              ),
              child: const Text('Open Location Settings'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _locationService.openLocationSettings();
              },
            ),
            TextButton(
              style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Color(0xFFFE724C)),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget allRestaurantsStack(
      {required String img,
      required String title,
      required String subtitle,
      required TextTheme theme,
      required ThemeData colorTheme}) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        //398,
        height: 172,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(img), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: theme.labelLarge
                          ?.copyWith(color: const Color(0xFF333333)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Fast food · Burger In....... · 200 starting........\nItalian Pizza · 0.66km',
                      style: theme.labelMedium
                          ?.copyWith(color: const Color(0xFF767676)),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.95,
              //372,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorTheme.primaryColor),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset('assets/svg/icons/bookmark.svg'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Free delivery + Extra 50% Off',
                    style: theme.titleSmall?.copyWith(
                        color: const Color(0xFFFFFFFF), fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
          top: 20,
          right: 10,
          child: SvgPicture.asset('assets/svg/bookmark/bookmark2.svg'))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leadingWidth: 40,
          forceMaterialTransparency: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () {
                showAddresses(context, theme, colorTheme);
              },
              child: SvgPicture.asset(
                'assets/svg/icons/location.svg',
              ),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              showAddresses(context, theme, colorTheme);
            },
            child: _isLoading
                ? Text('Fetching location...',
                    style: theme.labelMedium
                        ?.copyWith(color: colorTheme.primaryColor))
                : Text(
                    _address.isNotEmpty ? _address : 'Location not available',
                    overflow: TextOverflow.ellipsis,
                    style: theme.displayLarge,
                  ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderPage()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(colorTheme.primaryColor),
                  ),
                  child: Text(
                    'Orders',
                    style: theme.titleMedium
                        ?.copyWith(color: const Color(0xFFFFFFFF)),
                  )),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            border:
                                Border.all(color: colorTheme.indicatorColor),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF767676),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Search for ',
                                style: theme.displaySmall
                                    ?.copyWith(color: const Color(0xFF767676))),
                            Expanded(
                              child: TweenAnimationBuilder(
                                key: ValueKey<int>(index),
                                tween: Tween<Offset>(
                                  begin: const Offset(0, 0.2),
                                  end: const Offset(0, 0),
                                ), // Drop from top
                                duration: const Duration(milliseconds: 300),
                                builder: (context, Offset offset, child) {
                                  return FractionalTranslation(
                                    translation: offset,
                                    child: child,
                                  );
                                },
                                child: Text('"${searchList[index]}"',
                                    style: theme.displaySmall?.copyWith(
                                        color: const Color(0xFF767676))),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorTheme.shadowColor,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Powered by ONDC',
                          style: theme.bodyMedium
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colorTheme.shadowColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      itemSpace(
                          img: 'assets/images/Items-list/image1.png',
                          name: 'Daily Meals'),
                      itemSpace(
                          img: 'assets/images/Items-list/image2.png',
                          name: 'Biryani'),
                      itemSpace(
                          img: 'assets/images/Items-list/image3.png',
                          name: 'Chinese'),
                      itemSpace(
                          img: 'assets/images/Items-list/image4.png',
                          name: 'Desi'),
                      itemSpace(
                          img: 'assets/images/Items-list/image5.png',
                          name: 'Deshi'),
                      itemSpace(
                          img: 'assets/images/Items-list/image3.png',
                          name: 'Chinese'),
                      itemSpace(
                          img: 'assets/images/Items-list/image4.png',
                          name: 'Desi'),
                      itemSpace(
                          img: 'assets/images/Items-list/image5.png',
                          name: 'Deshi'),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 168,
                  child: PageView.builder(
                    itemCount: _cardTitles.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Card(child: adSpace(img: _cardTitles[index]));
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_cardTitles.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentIndex == index ? 8 : 7,
                      height: _currentIndex == index ? 8 : 7,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? colorTheme.primaryColor
                            : colorTheme.shadowColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 35,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      stackSpace(
                        img: 'assets/images/stack-images/img1.png',
                        name: 'Daily Meals',
                        color: const Color(0xFFFEC919),
                        context: context,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      stackSpace(
                        img: 'assets/images/stack-images/img2.png',
                        name: 'Tiffins',
                        color: const Color(0xFFD4CCFF),
                        context: context,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      stackSpace(
                        img: 'assets/images/stack-images/img3.png',
                        name: 'Quick Bites',
                        color: const Color(0xFFBDE9FE),
                        context: context,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      stackSpace(
                        img: 'assets/images/stack-images/img4.png',
                        name: 'Pan-Asian',
                        color: const Color(0xFFFFDACF),
                        context: context,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exclusively on Popular Brands',
                        style: theme.headlineSmall,
                      ),
                      Text(
                        'Delicious offers from top brands!',
                        style: theme.labelLarge?.copyWith(fontSize: 13),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 191,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          offerSpace(
                              img: 'assets/images/offerSpace/img1.png',
                              heading: '60% OFF',
                              subHeading: 'on BOWL COMPANY',
                              color1: const Color(0xFFEE6100),
                              color2: const Color(0xFFFFA05F)),
                          const SizedBox(
                            width: 10,
                          ),
                          offerSpace(
                              img: 'assets/images/offerSpace/img2.png',
                              heading: 'UPTO 60% OFF',
                              subHeading: 'on KFC',
                              color1: const Color(0xFFC8011A),
                              color2: const Color(0xFFFF4D63)),
                          const SizedBox(
                            width: 10,
                          ),
                          offerSpace(
                              img: 'assets/images/offerSpace/img3.png',
                              heading: '40% OFF',
                              subHeading: 'on MCDONALD’s',
                              color1: const Color(0xFFF1A100),
                              color2: const Color(0xFFFFB726)),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 370,
                        width: 345,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF1ED),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                              bottomLeft: Radius.circular(24)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, left: 16.0),
                                child: Text(
                                  'Top Offers for You',
                                  style: theme.headlineMedium?.copyWith(
                                      color: colorTheme.primaryColor,
                                      fontSize: 24),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Here’s what you might like to taste",
                                  style: theme.bodyMedium?.copyWith(
                                      color: const Color(0xFF767676)),
                                ),
                              )
                            ]),
                      ),
                      Positioned(
                        top: 40,
                        left: -30,
                        right: -30,
                        bottom: 0,
                        child: Center(
                          child: PageView.builder(
                            //pageSnapping: false, doesn't automatically moves the page when moved to the middle
                            controller: _pageController2,
                            onPageChanged: (int index) {
                              setState(() {
                                _currentIndex2 = index;
                              });
                            },
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 254,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 133,
                                          width: 190,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                topRight: Radius.circular(14)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/top-offers/img1.png'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Thick Shake',
                                            style: theme.titleMedium,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            'Shake Factory',
                                            style: theme.bodySmall,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '₹250',
                                              style: theme.titleSmall?.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationThickness: 1.8,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '₹200',
                                                style: theme.titleLarge
                                                    ?.copyWith(
                                                        color: colorTheme
                                                            .primaryColor),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 254,
                                        width: 190,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 133,
                                              width: 190,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(14),
                                                    topRight:
                                                        Radius.circular(14)),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/top-offers/img2.png'),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                'Milk Shake',
                                                style: theme.titleMedium,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                'Milkshake Factory',
                                                style: theme.bodySmall,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  '₹300',
                                                  style: theme.titleSmall
                                                      ?.copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationThickness: 1.8,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '₹250',
                                                    style: theme.titleLarge
                                                        ?.copyWith(
                                                            color: colorTheme
                                                                .primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: 124,
                                          left: 5,
                                          child: Container(
                                            width: 104,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.64)),
                                            child: Center(
                                              child: Text(
                                                'Free Delivery',
                                                style: theme.labelSmall
                                                    ?.copyWith(
                                                        color: const Color(
                                                            0xFF767676)),
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                          left: -7,
                                          top: 15,
                                          child: SvgPicture.asset(
                                              'assets/svg/bookmark/twenty_five_off.svg'))
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 20,
                        right: 20,
                        child: Row(
                          children: List.generate(3, (index) {
                            return Container(
                              height: 2.5,
                              width: 24,
                              decoration: BoxDecoration(
                                color: _currentIndex2 == index
                                    ? colorTheme.primaryColor // Active page
                                    : const Color(0xFFFFD3C8),
                                borderRadius: _currentIndex2 == 0
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      )
                                    : _currentIndex2 == 2
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          )
                                        : BorderRadius.circular(0),
                              ),
                              // Inactive pages
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All Restaurants',
                            style: theme.headlineSmall,
                          ),
                          Text(
                            '256 Restaurants near you',
                            style: theme.bodyLarge?.copyWith(fontSize: 15),
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        child: Text(
                          'See all',
                          style: theme.labelSmall,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, top: 10, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(14)),
                        child: Text(
                          'All',
                          style: theme.displaySmall
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(14)),
                        child: Text(
                          'Free Delivery',
                          style: theme.displaySmall
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(14)),
                        child: Text(
                          'Pure Veg',
                          style: theme.displaySmall
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEBEBEB),
                            borderRadius: BorderRadius.circular(14)),
                        child: Text(
                          'Offer',
                          style: theme.displaySmall
                              ?.copyWith(color: const Color(0xFF767676)),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    allRestaurantsStack(
                        img: 'assets/images/offers/img1.jpeg',
                        title: 'Pizza Hut',
                        subtitle: '30 mins',
                        theme: theme,
                        colorTheme: colorTheme),
                    allRestaurantsStack(
                        img: 'assets/images/offers/img2.png',
                        title: 'KFC Banani',
                        subtitle: '35 - 30 mins',
                        theme: theme,
                        colorTheme: colorTheme),
                  ],
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoryPage()));
                  },
                  child: Container(
                    height: 60,
                    width: 379,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: colorTheme.shadowColor)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View All Restaurants',
                            style: theme.titleLarge,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.navigate_next_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> showAddresses(
      BuildContext context, TextTheme theme, ThemeData colorTheme) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Stack(clipBehavior: Clip.none, children: [
            DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.9,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20.0)),
                    child: Container(
                      width:
                          MediaQuery.of(context) //size of width of the screen
                              .size
                              .width,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select Address',
                            style: theme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyAddress()));
                            },
                            child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colorTheme.indicatorColor,
                                    )),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '+',
                                      style: theme.bodyLarge?.copyWith(
                                          color: colorTheme.primaryColor,
                                          fontSize: 24),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'Add Address',
                                      style: theme.bodyLarge?.copyWith(
                                          color: colorTheme.primaryColor,
                                          fontSize: 15),
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Saved Addresses',
                            style:
                                theme.bodyLarge?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          addressSpace(
                              title: 'Home',
                              subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
                          const SizedBox(height: 8),
                          addressSpace(
                              title: 'Sai',
                              subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
                          const SizedBox(height: 8),
                          addressSpace(
                              title: 'Other',
                              subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
                          const SizedBox(height: 8),
                          addressSpace(
                              title: 'Work',
                              subtitle: '301 8-2-684/4/5 Anand Banjara Colony'),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                }),
            Positioned(
                top: -50,
                left: 0,
                right: 0,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )))
          ]);
        });
  }
}
// User? UserName(){
//   // User? user1= FirebaseAuth.instance.currentUser;
//   // user1!.displayName='Rahul';
//   return FirebaseAuth.instance.currentUser..displayName='';//cascade operator
// }

    // SizedBox(
                //   height: 10,
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: _cardTitles.length,
                //       itemBuilder: (context, index) {
                //         return AnimatedContainer(
                //           duration: const Duration(milliseconds: 300),
                //           margin: const EdgeInsets.symmetric(horizontal: 4),
                //           width: _currentIndex == index ? 8 : 7,
                //           height: _currentIndex == index ? 8 : 7,
                //           decoration: BoxDecoration(
                //             color: _currentIndex == index
                //                 ? colorTheme.primaryColor
                //                 : colorTheme.shadowColor,
                //             shape: BoxShape.circle,
                //           ),
                //         );
                //       }),
                // ),

                // Stack(children: [
                    //   SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     //398,
                    //     height: 172,
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Container(
                    //               height: 120,
                    //               width: 120,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(8),
                    //                 image: const DecorationImage(
                    //                     image: AssetImage(
                    //                         'assets/images/offers/img1.jpeg'),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 10,
                    //             ),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'Pizza Hut',
                    //                   style: theme.titleMedium,
                    //                 ),
                    //                 Text(
                    //                   '30 mins',
                    //                   style: theme.labelLarge?.copyWith(
                    //                       color: const Color(0xFF333333)),
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Text(
                    //                   'Fast food · Burger In....... · 200 starting........\nItalian Pizza · 0.66km',
                    //                   style: theme.labelMedium?.copyWith(
                    //                       color: const Color(0xFF767676)),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 5,
                    //         ),
                    //         Container(
                    //           height: 36,
                    //           width: MediaQuery.of(context).size.width * 0.95,
                    //           //372,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8),
                    //               color: colorTheme.primaryColor),
                    //           child: Row(
                    //             children: [
                    //               const SizedBox(
                    //                 width: 15,
                    //               ),
                    //               SvgPicture.asset(
                    //                   'assets/svg/icons/bookmark.svg'),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 'Free delivery + Extra 50% Off',
                    //                 style: theme.titleSmall?.copyWith(
                    //                     color: const Color(0xFFFFFFFF)),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   Positioned(
                    //       top: 20,
                    //       right: 10,
                    //       child: SvgPicture.asset(
                    //           'assets/svg/bookmark/bookmark2.svg'))
                    // ]),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16, right: 16),
                    //   child: Divider(
                    //     thickness: 0.8,
                    //     color: Color(0xFFECECEC),
                    //   ),
                    // ),
                    // Stack(children: [
                    //   SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     //398,
                    //     height: 172,
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const SizedBox(
                    //               width: 12,
                    //             ),
                    //             Container(
                    //               height: 100,
                    //               width: 100,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(8),
                    //                 image: const DecorationImage(
                    //                     image: AssetImage(
                    //                         'assets/images/offers/img2.png'),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 18,
                    //             ),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'KFC Banani',
                    //                   style: theme.titleMedium,
                    //                 ),
                    //                 Text(
                    //                   '35 - 30 mins',
                    //                   style: theme.labelLarge?.copyWith(
                    //                       color: const Color(0xFF333333)),
                    //                 ),
                    //                 const SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Text(
                    //                   'Fast food · Burger In....... · ₹200 starting........\nItalian Pizza · 0.66km',
                    //                   style: theme.labelMedium?.copyWith(
                    //                       color: const Color(0xFF767676)),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 15,
                    //         ),
                    //         Container(
                    //           height: 36,
                    //           width: MediaQuery.of(context).size.width * 0.95,
                    //           //372,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8),
                    //               color: colorTheme.primaryColor),
                    //           child: Row(
                    //             children: [
                    //               const SizedBox(
                    //                 width: 15,
                    //               ),
                    //               SvgPicture.asset(
                    //                   'assets/svg/icons/bookmark.svg'),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 'Free delivery + Extra 50% Off',
                    //                 style: theme.titleSmall?.copyWith(
                    //                     color: const Color(0xFFFFFFFF)),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   Positioned(
                    //       top: 10,
                    //       right: 10,
                    //       child: SvgPicture.asset(
                    //           'assets/svg/bookmark/bookmark2.svg'))
                    // ]),


                     // const SizedBox(
                //   height: 10,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //           height: 24,
                //           width: 24,
                //           child: SvgPicture.asset(
                //               'assets/svg/icons/location.svg')),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       Expanded(
                //           child: _isLoading
                //               ? Text('Fetching location...',
                //                   style:
                //                       TextStyle(color: colorTheme.primaryColor))
                //               : Text(
                //                   _address.isNotEmpty
                //                       ? _address
                //                       : 'Location not available',
                //                   overflow: TextOverflow.ellipsis,
                //                   style: theme.displayLarge,
                //                 )),
                //       TextButton(
                //           onPressed: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => const OrderPage()));
                //           },
                //           style: ButtonStyle(
                //             backgroundColor:
                //                 WidgetStatePropertyAll(colorTheme.primaryColor),
                //           ),
                //           child: Text(
                //             'Orders',
                //             style: theme.titleMedium
                //                 ?.copyWith(color: const Color(0xFFFFFFFF)),
                //           ))
                //     ],
                //   ),
                // ),