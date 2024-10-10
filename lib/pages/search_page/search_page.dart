import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'popular_items_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late TabController _tabController;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);

    _searchController.addListener(() {
      setState(() {
        _isSearching = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Widget cardItem({required String name, required TextTheme theme}) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
        child: Text(
          name,
          style: theme.labelLarge
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget allRestaurantsStack({
    required String img,
    required String title,
    required String subtitle,
    required TextTheme theme,
    required ThemeData colorTheme,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
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
                        image: AssetImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.titleMedium,
                      ),
                      Text(
                        subtitle,
                        style: theme.labelLarge?.copyWith(
                          color: const Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Fast food · Burger In....... · 200 starting........\nItalian Pizza · 0.66km',
                        style: theme.labelMedium?.copyWith(
                          color: const Color(0xFF767676),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Container(
                height: 36,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorTheme.primaryColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    SvgPicture.asset('assets/svg/icons/bookmark.svg'),
                    const SizedBox(width: 5),
                    Text(
                      'Free delivery + Extra 50% Off',
                      style: theme.titleSmall?.copyWith(
                        color: const Color(0xFFFFFFFF),
                      ),
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
          child: SvgPicture.asset('assets/svg/bookmark/bookmark2.svg'),
        ),
      ],
    );
  }

  Widget dishItem(
      {required String title,
      required String location,
      required String img,
      required String heading,
      required String subHeading,
      required String cost,
      required TextTheme theme}) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: theme.headlineMedium,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward))
            ],
          ),
          Text(
            'Chinese, North Indian, South Indian',
            style: theme.bodyMedium,
          ),
          Row(
            children: [
              Text(
                '30 min',
                style: theme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color(0xFFA1A1A1)),
                ),
              ),
              Text(
                location,
                style:
                    theme.bodyMedium?.copyWith(color: const Color(0xFF333333)),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Card(
            //elevation: 2,
            child: Container(
              height: 136,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Container(
                    height: 136,
                    width: 136,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(img), fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            heading,
                            style: const TextStyle(
                                color: Color(0xFF333333),
                                fontFamily: 'Merienda',
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(subHeading,
                              style: const TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF999999),
                              )),
                          const Spacer(),
                          SizedBox(
                            child: Row(
                              children: [
                                Text('₹$cost',
                                    style: const TextStyle(
                                        fontFamily: 'Merienda',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFE724C))),
                                const Spacer(),
                                Container(
                                  width: 79,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: const Color(0xFFC0C0C0)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        color: Color(0xFFFE724C),
                                        fontFamily: 'Merienda',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final ThemeData colorTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search your food nearby...',
                  hintStyle: theme.displaySmall?.copyWith(
                    color: const Color(0xFF767676),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF767676),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFEBEBEB),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFC0C0C0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorTheme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isSearching
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            indicatorColor: colorTheme.primaryColor,
                            controller: _tabController,
                            labelColor: colorTheme.primaryColor,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: const [
                              Tab(text: "Dishes"),
                              Tab(text: "Restaurant"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                ListView(
                                  children: [
                                    dishItem(
                                        title: 'McDonald\'s',
                                        location: 'PVR Banjara Hills',
                                        img:
                                            'assets/images/category-page/mcdonalds/img2.png',
                                        heading: 'Combo Burger',
                                        subHeading:
                                            'Shortbread, chocolate turtle \ncookies, and red velvet.',
                                        cost: '250',
                                        theme: theme),
                                    Expanded(
                                      child: Divider(
                                        color: colorTheme.indicatorColor,
                                      ),
                                    ),
                                    dishItem(
                                        title: 'Pizza Hut',
                                        location: 'Banjara Hills',
                                        img:
                                            'assets/images/category-page/mcdonalds/img3.png',
                                        heading: 'Combo Burger',
                                        subHeading:
                                            'Shortbread, chocolate turtle \ncookies, and red velvet.',
                                        cost: '250',
                                        theme: theme),
                                    Expanded(
                                      child: Divider(
                                        color: colorTheme.indicatorColor,
                                      ),
                                    ),
                                  ],
                                ),
                                ListView(
                                  children: [
                                    allRestaurantsStack(
                                      img: 'assets/images/offers/img1.jpeg',
                                      title: 'Pizza Hut',
                                      subtitle: '30 mins',
                                      theme: theme,
                                      colorTheme: colorTheme,
                                    ),
                                    allRestaurantsStack(
                                      img: 'assets/images/offers/img2.png',
                                      title: 'KFC Banani',
                                      subtitle: '35 - 30 mins',
                                      theme: theme,
                                      colorTheme: colorTheme,
                                    ),
                                    allRestaurantsStack(
                                      img: 'assets/images/offers/img1.jpeg',
                                      title: 'Pizza Hut',
                                      subtitle: '30 mins',
                                      theme: theme,
                                      colorTheme: colorTheme,
                                    ),
                                    allRestaurantsStack(
                                      img: 'assets/images/offers/img2.png',
                                      title: 'KFC Banani',
                                      subtitle: '35 - 30 mins',
                                      theme: theme,
                                      colorTheme: colorTheme,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        children: [
                          Center(
                            child: Text(
                              'Recently Searched Restaurants/Dishes',
                              style: theme.titleSmall
                                  ?.copyWith(color: const Color(0xFF767676)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              for (int i = 0; i < 3; i++)
                                cardItem(
                                  name: popularItemsList[i],
                                  theme: theme,
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              // const SizedBox(width: 10),
                              for (int i = 3; i < popularItemsList.length; i++)
                                cardItem(
                                  name: popularItemsList[i],
                                  theme: theme,
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Text(
                          //   'Exclusive Restaurants',
                          //   style: theme.titleLarge?.copyWith(
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          // Text(
                          //   'Delicious offers from top brands!',
                          //   style: theme.bodyLarge?.copyWith(fontSize: 13),
                          // ),
                          // allRestaurantsStack(
                          //   img: 'assets/images/offers/img1.jpeg',
                          //   title: 'Pizza Hut',
                          //   subtitle: '30 mins',
                          //   theme: theme,
                          //   colorTheme: colorTheme,
                          // ),
                          // allRestaurantsStack(
                          //   img: 'assets/images/offers/img2.png',
                          //   title: 'KFC Banani',
                          //   subtitle: '35 - 30 mins',
                          //   theme: theme,
                          //   colorTheme: colorTheme,
                          // ),
                          // allRestaurantsStack(
                          //   img: 'assets/images/offers/img1.jpeg',
                          //   title: 'Pizza Hut',
                          //   subtitle: '30 mins',
                          //   theme: theme,
                          //   colorTheme: colorTheme,
                          // ),
                          // allRestaurantsStack(
                          //   img: 'assets/images/offers/img2.png',
                          //   title: 'KFC Banani',
                          //   subtitle: '35 - 30 mins',
                          //   theme: theme,
                          //   colorTheme: colorTheme,
                          // ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
