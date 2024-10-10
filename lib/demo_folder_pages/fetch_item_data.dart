import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantMenuPage extends StatefulWidget {
  final String restaurantId;

  const RestaurantMenuPage({super.key, required this.restaurantId});

  @override
  _RestaurantMenuPageState createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  String selectedCategory = ''; // Variable to track selected category
  Map<String, dynamic> itemsMap =
      {}; // To store items for the selected category

  @override
  void initState() {
    super.initState();
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
      print('Error fetching menu categories: $e');
    }

    return categories;
  }

  Future<void> fetchItemsForCategory(String categoryName) async {
    if (categoryName.isEmpty) return;

    try {
      DocumentReference menuDocRef = FirebaseFirestore.instance
          .collection('items')
          .doc(widget.restaurantId)
          .collection('menu')
          .doc(categoryName);

      DocumentSnapshot menuDoc = await menuDocRef.get();

      if (menuDoc.exists) {
        setState(() {
          itemsMap = menuDoc.data() as Map<String, dynamic>; // Update items
        });
      }
    } catch (e) {
      print('Error fetching items for category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Menu'),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchMenuCategories(widget.restaurantId),
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

          return Column(
            children: [
              // Horizontal scrollable list of categories
              SizedBox(
                height: 80, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    String categoryName = categories[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = categoryName;
                          fetchItemsForCategory(selectedCategory);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedCategory == categoryName
                              ? Colors.blueAccent
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            categoryName,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // ListView for items in the selected category
              Expanded(
                child: itemsMap.isEmpty
                    ? const Center(child: Text('No items found.'))
                    : ListView.builder(
                        itemCount: itemsMap.length,
                        itemBuilder: (context, index) {
                          String itemName = itemsMap.keys.elementAt(index);
                          String itemPrice = itemsMap[itemName]['price'];

                          return ListTile(
                            title: Text(itemName),
                            subtitle: Text('Price: ₹$itemPrice'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
