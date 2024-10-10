import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/pages/cart_pages/cart1_page.dart';
//import 'package:food_delivery_app/pages/cart_pages/cart_page.dart';
import 'package:food_delivery_app/pages/cart_pages/cart_provider.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatefulWidget {
  final String restaurantID;
  final String pageImage;
  final String pageHeading;
  final String pageSubHeading;

  const RestaurantPage(
      {required this.restaurantID,
      required this.pageImage,
      required this.pageHeading,
      required this.pageSubHeading,
      super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  late CartProvider provider;
  bool veg = false;
  bool nonVeg = false;

  bool isVegSelected = false;
  bool isNonVegSelected = false;

  String selectedCategory = '';
  Map<String, dynamic> itemsMap = {};
  Map<String, dynamic> filterItemsMap = {};

  @override
  void initState() {
    super.initState();
    filterItemsMap = Map.from(itemsMap);
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
      required bool type,
      required String itemName}) {
    return Column(
      children: [
        Card(
          elevation: 1,
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width, //398,
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
                        image: NetworkImage(img), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              heading,
                              style: const TextStyle(
                                  color: Color(0xFF333333),
                                  fontFamily: 'Merienda',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            type
                                ? SvgPicture.asset(
                                    'assets/svg/veg_non-veg/veg.svg')
                                : SvgPicture.asset(
                                    'assets/svg/veg_non-veg/non_veg.svg')
                          ],
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
                              GestureDetector(
                                onTap: () => {
                                  showCustomizationSheet(itemsMap, itemName),
                                },
                                child: Container(
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
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Future<dynamic> showCustomizationSheet(
      Map<String, dynamic> itemsMap, String itemName) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.35,
          maxChildSize: 0.35,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Combo Sandwich'),
                          const Text(
                            'Customize to your liking',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Merienda',
                                color: Colors.black),
                          ),
                          const Divider(
                            color: Color(0xFFC0C0C0),
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'Choose Your Favourite Sandwich Bread (Optional)'),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: ListView(
                              controller: scrollController,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                CustomCheckboxTile(
                                  title: 'Wheat',
                                  cost: '20',
                                  value: isChecked1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked1 = value ?? false;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomCheckboxTile(
                                  title: 'Multi-Grain',
                                  cost: '50',
                                  value: isChecked2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked2 = value ?? false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  side: WidgetStatePropertyAll(BorderSide(
                                      color: Colors.grey, width: 0.5)),
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                ),
                                onPressed: () {
                                  if (provider.cart.isNotEmpty &&
                                      provider.cart[0][0] !=
                                          widget.pageHeading) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Clear Cart?'),
                                          content: const Text(
                                            'Your cart contains items from another restaurant. Do you want to clear the cart and add the new item?',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Color(0xFFFE724C)),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                'Clear Cart and Add',
                                                style: TextStyle(
                                                    color: Color(0xFFFE724C)),
                                              ),
                                              onPressed: () {
                                                provider
                                                    .reset(); // Clear the cart
                                                provider.add(
                                                    restaurantName:
                                                        widget.pageHeading,
                                                    address:
                                                        'McDonald’s, Cubbon Park, Hyderabad',
                                                    itemName: itemsMap[itemName]
                                                        ['name'],
                                                    img: itemsMap[itemName]
                                                        ['image'],
                                                    cost: itemsMap[itemName]
                                                        ['price'],
                                                    type: itemsMap[itemName]
                                                        ['type']);
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                Navigator.of(context)
                                                    .pop(); // Close the customization sheet

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Item added successfully'),
                                                    backgroundColor:
                                                        Color(0xFFFE724C),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    provider.add(
                                        restaurantName: widget.pageHeading,
                                        address:
                                            'McDonald’s, Cubbon Park, Hyderabad',
                                        itemName: itemsMap[itemName]['name'],
                                        img: itemsMap[itemName]['image'],
                                        cost: itemsMap[itemName]['price'],
                                        type: itemsMap[itemName]['type']);
                                    Navigator.of(context)
                                        .pop(); // Close the customization sheet

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Item added successfully'),
                                        backgroundColor: Color(0xFFFE724C),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Add to Cart',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          color: const Color(0xFFFE724C)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ]);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<String>> fetchMenuCategories(String restaurantId) async {
    List<String> categories = [];

    try {
      CollectionReference menuCollection = FirebaseFirestore.instance
          .collection('items')
          .doc(restaurantId)
          .collection('menu');

      var menuSnapshot = await menuCollection.get();
      for (var menuDoc in menuSnapshot.docs) {
        categories.add(menuDoc.id); // Add document ID as category name
      }
    } catch (e) {
      debugPrint('Error fetching menu categories: $e');
    }

    return categories;
  }

  Future<void> fetchItemsForCategory(String categoryName) async {
    if (categoryName.isEmpty) return;

    try {
      DocumentReference menuDocRef = FirebaseFirestore.instance
          .collection('items')
          .doc(widget.restaurantID)
          .collection('menu')
          .doc(categoryName);

      DocumentSnapshot menuDoc = await menuDocRef.get();

      if (menuDoc.exists) {
        setState(() {
          itemsMap = menuDoc.data() as Map<String, dynamic>; // Update items
          filterItemsMap = menuDoc.data() as Map<String, dynamic>; // filter map
        });
      }
    } catch (e) {
      debugPrint('Error fetching items for category: $e');
    }
  }

  void filterItems() {
    setState(() {
      filterItemsMap.clear();
      if (veg && nonVeg) {
        // If both veg and nonVeg are true, show all items
        itemsMap.forEach((key, item) {
          filterItemsMap[key] = item;
        });
      } else if (veg) {
        // If only veg is true, show only veg items
        itemsMap.forEach((key, item) {
          if (item['type'] == true) {
            filterItemsMap[key] = item;
          }
        });
      } else if (nonVeg) {
        // If only nonVeg is true, show only nonVeg items
        itemsMap.forEach((key, item) {
          if (item['type'] == false) {
            filterItemsMap[key] = item;
          }
        });
      } else {
        // If both veg and nonVeg are false, show all items
        itemsMap.forEach((key, item) {
          filterItemsMap[key] = item;
        });
      }
    });
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
      body: FutureBuilder<List<String>>(
        future: fetchMenuCategories(widget.restaurantID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No menu categories found.'));
          }

          List<String> categories = snapshot.data!;

          // Select the first category by default
          if (selectedCategory.isEmpty) {
            selectedCategory = categories.first;
            fetchItemsForCategory(
                selectedCategory); // Fetch items for the first category
          }

          return Stack(children: [
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Image.network(widget.pageImage, fit: BoxFit.cover),
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('4.5',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
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
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Text(
                        widget.pageSubHeading,
                        style: bodyMedium?.copyWith(
                            color: const Color(0xFF767676)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 6),
                      child: Text(
                        '₹200 for two',
                        style: titleLarge?.copyWith(color: primaryColor),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 6),
                      child: Row(
                        children: [
                          Text(
                            '30 min',
                            style: bodyMedium?.copyWith(
                                color: const Color(0xFF333333)),
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
                            style: bodyMedium?.copyWith(
                                color: const Color(0xFF333333)),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              veg = !veg;
                              nonVeg = veg ? false : nonVeg;
                              isVegSelected = !isVegSelected;
                              filterItems();
                            });
                          },
                          child: Container(
                            width: 77,
                            height: 32,
                            decoration: BoxDecoration(
                                color: veg ? Colors.green : Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: Colors.green)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Veg',
                                  style: titleMedium?.copyWith(
                                      color: veg ? Colors.white : Colors.green),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  height: 17,
                                  width: 17,
                                  color: Colors.white,
                                  child: SvgPicture.asset(
                                    'assets/svg/veg_non-veg/veg.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              nonVeg = !nonVeg;
                              veg = nonVeg ? false : veg;
                              isNonVegSelected = !isNonVegSelected;
                              filterItems();
                            });
                          },
                          child: Container(
                            width: 117,
                            height: 32,
                            decoration: BoxDecoration(
                                color: nonVeg ? Colors.red : Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: Colors.red)),
                            child: Center(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Non-Veg',
                                    style: titleMedium?.copyWith(
                                        color:
                                            nonVeg ? Colors.white : Colors.red),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    height: 17,
                                    width: 17,
                                    color: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/svg/veg_non-veg/non_veg.svg',
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 30, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          String categoryName = categories[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = categoryName;
                                  fetchItemsForCategory(selectedCategory);
                                });
                              },
                              child: SizedBox(
                                height: 30,
                                child: Center(
                                  child:
                                      Text(capitalizeFirstLetter(categoryName),
                                          style: titleMedium?.copyWith(
                                            color:
                                                selectedCategory == categoryName
                                                    ? Colors.black
                                                    : Colors.grey,
                                          )),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: filterItemsMap.isEmpty
                          ? const Center(
                              child: Text('No items found'),
                            )
                          : ListView.builder(
                              itemCount: filterItemsMap.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 40),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                String itemName =
                                    filterItemsMap.keys.elementAt(index);
                                return cardItem(
                                    img: filterItemsMap[itemName]['image'],
                                    heading: capitalizeFirstLetter(
                                        filterItemsMap[itemName]['name']),
                                    subHeading: itemsMap[itemName]
                                        ['description'],
                                    cost: filterItemsMap[itemName]['price'],
                                    type: filterItemsMap[itemName]['type'],
                                    itemName: itemName);
                              }),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, provider, child) {
                        return provider.cart.isNotEmpty
                            ? const SizedBox(
                                height: 90,
                              )
                            : const SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ),
            Consumer<CartProvider>(builder: (context, provider, child) {
              return provider.cart.isNotEmpty
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(12)),
                            color: Colors.white),
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                color: Color(0xFFFEA187),
                              ),
                              height: 57,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'You’re saving ${provider.coupon} on this order',
                                  style: const TextStyle(
                                    fontFamily: 'Merienda',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  '${provider.cart.length.toString()} ${provider.cart.length > 1 ? 'items' : 'item'}',
                                  style: titleSmall?.copyWith(fontSize: 14),
                                ),
                                const Text('-'),
                                Text(
                                  '₹ ${provider.totalCost().toStringAsFixed(0)}',
                                  style: titleSmall?.copyWith(fontSize: 14),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Cart1Page()),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: const Color(0xFFC0C0C0))),
                                    child: Center(
                                      child: Text(
                                        'View Cart',
                                        style: titleSmall?.copyWith(
                                            color: primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                  : Container();
            }),
          ]);
        },
      ),
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final String cost;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxTile({
    required this.title,
    required this.cost,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Merienda',
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
              ),
              const Spacer(),
              Text(
                '₹$cost',
                style: const TextStyle(
                  fontFamily: 'Merienda',
                  fontSize: 16,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFE724C),
          ),
        ),
      ],
    );
  }
}
