import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/demo_folder_pages/demo_cart_page.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:provider/provider.dart';
import '../pages/restaurant_pages/category/restaurant_menu_list_items.dart';

class RestaurantPage extends StatefulWidget {
  final String pageImage;
  final String pageHeading;
  final String pageSubHeading;

  const RestaurantPage(
      {required this.pageImage,
      required this.pageHeading,
      required this.pageSubHeading,
      super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool isTextSelected1 = false;
  bool isTextSelected2 = false;
  bool isTextSelected3 = false;
  bool isTextSelected4 = false;
  bool isTextSelected5 = false;
  bool isTextSelected6 = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  List<List<String>> selectedList = [];
  late int index;
  late CartProvider provider;

  @override
  void initState() {
    setState(() {
      isTextSelected1 = true;
      selectedList = beefAndLamb;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to access the provider here
    provider = Provider.of<CartProvider>(context, listen: false);
  }

  Widget cardItem(
      {required String img,
      required String heading,
      required String subHeading,
      required String cost,
      required int index}) {
    return Card(
      elevation: 2,
      child: Container(
        height: 136,
        width: 398,
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              height: 136,
              width: 136,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(8),
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
              ),
            ),
            Padding(
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
                        const SizedBox(
                          width: 80,
                        ),
                        GestureDetector(
                          onTap: () => {
                            provider.add(
                                restaurantName: widget.pageHeading,
                                address: 'McDonald’s, Cubbon Park, Hyderabad',
                                itemName: selectedList[index][1],
                                img: selectedList[index][0],
                                cost: cost,
                                type: true),
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return DraggableScrollableSheet(
                                  expand: false,
                                  builder: (BuildContext context,
                                      ScrollController scrollController) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20.0)),
                                      child: Container(
                                        color: Colors.white,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Text(
                                                    'Cart',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView(
                                                    controller:
                                                        scrollController,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16),
                                                    children: [
                                                      // CheckboxListTile(
                                                      //   title: const Text(
                                                      //     'Wheat',
                                                      //     style: TextStyle(
                                                      //         fontFamily:
                                                      //             'Merienda',
                                                      //         fontSize: 14,
                                                      //         color: Color(
                                                      //             0xFF000000)),
                                                      //   ),
                                                      //   value: isChecked1,
                                                      //   onChanged:
                                                      //       (bool? value) {
                                                      //     setState(() {
                                                      //       isChecked1 =
                                                      //           value ?? false;
                                                      //     });
                                                      //   },
                                                      //   activeColor:
                                                      //       const Color(
                                                      //           0xFFFE724C),
                                                      // ),
                                                      // CheckboxListTile(
                                                      //   title: const Text(
                                                      //     'Multi-Grain',
                                                      //     style: TextStyle(
                                                      //         fontFamily:
                                                      //             'Merienda',
                                                      //         fontSize: 14,
                                                      //         color: Color(
                                                      //             0xFF000000)),
                                                      //   ),
                                                      //   value: isChecked2,
                                                      //   onChanged:
                                                      //       (bool? value) {
                                                      //     setState(() {
                                                      //       isChecked2 =
                                                      //           value ?? false;
                                                      //     });
                                                      //   },
                                                      //   activeColor:
                                                      //       const Color(
                                                      //           0xFFFE724C),
                                                      // ),
                                                      CheckboxListTile(
                                                        title: const Text(
                                                            'Option 1'),
                                                        value: isChecked1,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            isChecked1 =
                                                                value ?? false;
                                                          });
                                                        },
                                                        activeColor:
                                                            const Color(
                                                                0xFFFE724C),
                                                      ),
                                                      CheckboxListTile(
                                                        title: const Text(
                                                            'Option 2'),
                                                        value: isChecked2,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            isChecked2 =
                                                                value ?? false;
                                                          });
                                                        },
                                                        activeColor:
                                                            const Color(
                                                                0xFFFE724C),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Theme.of(context)
                                                                  .primaryColor),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const DemoCartPage()),
                                                      );
                                                    },
                                                    child: Text(
                                                      'View Cart',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall
                                                          ?.copyWith(
                                                              color: const Color(
                                                                  0xFFFFFFFF)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          },
                          child: Container(
                            width: 79,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: const Color(0xFFC0C0C0)),
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
                        ),

                        // GestureDetector(
                        //   onTap: () => {
                        //     provider.add(
                        //       restaurantName: widget.pageHeading,
                        //       address: 'McDonald’s, Cubbon Park, Hyderabad',
                        //       itemName: selectedList[index][1],
                        //       img: selectedList[index][0],
                        //       cost: cost,
                        //     ),
                        //     showModalBottomSheet(
                        //         context: context,
                        //         isScrollControlled: true,
                        //         builder: (BuildContext context) {
                        //           return DraggableScrollableSheet(
                        //               expand: false,
                        //               builder: (BuildContext context,
                        //                   ScrollController scrollController) {
                        //                 return ClipRRect(
                        //                   borderRadius:
                        //                       const BorderRadius.vertical(
                        //                           top: Radius.circular(20.0)),
                        //                   child: Container(
                        //                     color: Colors.white,
                        //                     child: Column(
                        //                       children: [
                        //                         Padding(
                        //                           padding:
                        //                               const EdgeInsets.all(16),
                        //                           child: Text(
                        //                             'Cart',
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .bodyLarge,
                        //                           ),
                        //                         ),
                        //                         Expanded(
                        //                           child: ListView(
                        //                             controller:
                        //                                 scrollController,
                        //                             padding: const EdgeInsets
                        //                                 .symmetric(
                        //                                 horizontal: 16),
                        //                             children: [
                        //                               CheckboxListTile(
                        //                                 title: const Text(
                        //                                     'Option 1'),
                        //                                 value:
                        //                                     isChecked1, // Initial value
                        //                                 onChanged:
                        //                                     (bool? value) {
                        //                                   setState(() {
                        //                                     isChecked1 =
                        //                                         value ?? false;
                        //                                   });
                        //                                 },
                        //                                 activeColor:
                        //                                     const Color(
                        //                                         0xFFFE724C),
                        //                               ),
                        //                               CheckboxListTile(
                        //                                 title: const Text(
                        //                                     'Option 2'),
                        //                                 value:
                        //                                     isChecked2, // Initial value
                        //                                 onChanged:
                        //                                     (bool? value) {
                        //                                   setState(() {
                        //                                     isChecked2 =
                        //                                         value ?? false;
                        //                                   });
                        //                                 },
                        //                               ),
                        //                               // Add other list items here if needed
                        //                             ],
                        //                           ),
                        //                         ),
                        //                         // Expanded(
                        //                         //     child: ListView(
                        //                         //   controller: scrollController,
                        //                         //   padding: const EdgeInsets
                        //                         //       .symmetric(
                        //                         //       horizontal: 16),
                        //                         //   children: const [
                        //                         //     // Add your cart item widgets here
                        //                         //     ListTile(
                        //                         //       title: Text('Item 1'),
                        //                         //       subtitle: Text(
                        //                         //           'Description of Item 1'),
                        //                         //     ),
                        //                         //     // Add more items as needed
                        //                         //   ],
                        //                         // )),
                        //                         Padding(
                        //                           padding: const EdgeInsets.all(
                        //                               16.0),
                        //                           child: ElevatedButton(
                        //                             style: ButtonStyle(
                        //                                 backgroundColor:
                        //                                     WidgetStatePropertyAll(
                        //                                         Theme.of(
                        //                                                 context)
                        //                                             .primaryColor)),
                        //                             onPressed: () {
                        //                               Navigator.push(
                        //                                   context,
                        //                                   MaterialPageRoute(
                        //                                       builder: (context) =>
                        //                                           const DemoCartPage()));
                        //                             },
                        //                             child: Text(
                        //                               'View Cart',
                        //                               style: Theme.of(context)
                        //                                   .textTheme
                        //                                   .headlineSmall
                        //                                   ?.copyWith(
                        //                                       color: const Color(
                        //                                           0xFFFFFFFF)),
                        //                             ),
                        //                           ),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 );
                        //               });
                        //         })
                        //   },
                        //   //   () {
                        //   // showModalBottomSheet(
                        //   //   context: context,
                        //   //   isScrollControlled: true,
                        //   //   builder: (context) => const CustomBottomSheet(),
                        //   // );
                        //   //},
                        //   child: Container(
                        //     width: 79,
                        //     height: 32,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(16),
                        //         border:
                        //             Border.all(color: const Color(0xFFC0C0C0))),
                        //     child: const Center(
                        //       child: Text(
                        //         'Add',
                        //         style: TextStyle(
                        //             color: Color(0xFFFE724C),
                        //             fontFamily: 'Merienda',
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final headlineMedium = Theme.of(context).textTheme.headlineMedium;
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    final titleSmall = Theme.of(context).textTheme.titleSmall;
    final displaySmall = Theme.of(context).textTheme.displaySmall;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Image.asset(widget.pageImage),
                Positioned(
                    top: 50,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: const Color(0xFFFFFFFF),
                    )),
                Positioned(
                    top: 50,
                    right: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                      color: const Color(0xFFFFFFFF),
                    ))
              ]),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      widget.pageHeading,
                      style: headlineMedium,
                    ),
                    const Spacer(),
                    Container(
                      height: 36,
                      width: 94,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('4.5',
                              style: titleMedium?.copyWith(
                                  color: const Color(0xFFFFFFFF))),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Text(
                  widget.pageSubHeading,
                  style: bodyMedium?.copyWith(color: const Color(0xFF767676)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                child: Text(
                  '₹200 for two',
                  style: titleLarge?.copyWith(color: primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                child: Row(
                  children: [
                    Text(
                      '30 min',
                      style:
                          bodyMedium?.copyWith(color: const Color(0xFF333333)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.circle,
                      size: 4,
                      color: Color(0xFF767676),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Cubbon Park',
                      style:
                          bodyMedium?.copyWith(color: const Color(0xFF333333)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 10),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset('assets/svg/icons/bookmark.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                          'Free delivery + Extra 10% Off on selected items',
                          style: titleSmall?.copyWith(
                              color: const Color(0xFFFFFFFF)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Divider(
                  thickness: 0.5,
                  color: Color(0xFFC0C0C0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search your food nearby...',
                      hintStyle: displaySmall?.copyWith(
                          color: const Color(0xFF767676)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF767676),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEBEBEB),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFC0C0C0), width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 77,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: const Color(0xFFC0C0C0))),
                    child: Center(
                      child: Text(
                        'Veg',
                        style: titleMedium?.copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    width: 117,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: const Color(0xFFC0C0C0))),
                    child: Center(
                      child: Text(
                        'Non-Veg',
                        style: titleMedium?.copyWith(color: primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextSelected2 = isTextSelected3 = isTextSelected4 =
                              isTextSelected5 = isTextSelected6 = false;
                          isTextSelected1 = !isTextSelected1;
                          selectedList = beefAndLamb;
                        });
                      },
                      child: Text(
                        'Beef & Lamb',
                        style: titleMedium?.copyWith(
                            color: isTextSelected1
                                ? const Color(0xFF333333)
                                : const Color(0xFFA1A1A1)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextSelected1 = isTextSelected3 = isTextSelected4 =
                              isTextSelected5 = isTextSelected6 = false;
                          isTextSelected2 = true;
                          selectedList = seaFood;
                        });
                      },
                      child: Text(
                        'Seafood',
                        style: titleMedium?.copyWith(
                            color: isTextSelected2
                                ? const Color(0xFF333333)
                                : const Color(0xFFA1A1A1)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextSelected1 = isTextSelected2 = isTextSelected4 =
                              isTextSelected5 = isTextSelected6 = false;
                          isTextSelected3 = true;
                          selectedList = appetizers;
                        });
                      },
                      child: Text(
                        'Appetizers',
                        style: titleMedium?.copyWith(
                            color: isTextSelected3
                                ? const Color(0xFF333333)
                                : const Color(0xFFA1A1A1)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextSelected1 = isTextSelected2 = isTextSelected3 =
                              isTextSelected5 = isTextSelected6 = false;
                          isTextSelected4 = true;
                          selectedList = dimSum;
                        });
                      },
                      child: Text(
                        'Dim Sum',
                        style: titleMedium?.copyWith(
                            color: isTextSelected4
                                ? const Color(0xFF333333)
                                : const Color(0xFFA1A1A1)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextSelected1 = isTextSelected2 = isTextSelected3 =
                              isTextSelected4 = isTextSelected6 = false;
                          isTextSelected5 = true;
                          selectedList = soups;
                        });
                      },
                      child: Text(
                        'Soups',
                        style: titleMedium?.copyWith(
                            color: isTextSelected5
                                ? const Color(0xFF333333)
                                : const Color(0xFFA1A1A1)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTextSelected1 = isTextSelected2 = isTextSelected3 =
                              isTextSelected4 = isTextSelected5 = false;
                          isTextSelected6 = true;
                          selectedList = curries;
                        });
                      },
                      child: Text(
                        'Curries',
                        style: titleMedium?.copyWith(
                            color: isTextSelected6
                                ? const Color(0xFF333333)
                                : const Color(0xFFA1A1A1)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ListView.builder(
                    itemCount: selectedList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return cardItem(
                          img: selectedList[index][0],
                          heading: selectedList[index][1],
                          subHeading: selectedList[index][2],
                          cost: selectedList[index][3],
                          index: index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5, // 1/4th of the screen height
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.9,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return CustomizationOptions(scrollController: scrollController);
        },
      ),
    );
  }
}

class CustomizationOptions extends StatelessWidget {
  final ScrollController scrollController;

  const CustomizationOptions({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Combo Sandwich'),
            const Text(
              'Customize to your liking',
              style: TextStyle(
                  fontSize: 24, fontFamily: 'Merienda', color: Colors.black),
            ),
            const Divider(
              color: Color(0xFFC0C0C0),
              thickness: 0.5,
            ),
            const SizedBox(height: 10),
            const Text('Choose Your Favourite Sandwich Bread (Optional)'),
            const CustomizationOption(
              title: 'Wheat',
              cost: '20',
            ),
            const CustomizationOption(
              title: 'Multi-grain',
              cost: '50',
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  // style: ButtonStyle(),
                  onPressed: () {},
                  child: const Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Merienda',
                        color: Color(0xFFFE724C)),
                  )),
            )
            // Add more options as needed
          ],
        ),
      ),
    );
  }
}

class CustomizationOption extends StatelessWidget {
  final String title;
  final String cost;
  const CustomizationOption(
      {super.key, required this.title, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontFamily: 'Merienda'),
            ),
            const Spacer(),
            Text(
              cost,
              style: const TextStyle(fontFamily: 'Merienda'),
            )
          ],
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Handle the tap event
        },
      ),
    );
  }
}
