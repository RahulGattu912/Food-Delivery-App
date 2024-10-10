import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> addItem(
    String restaurantId,
    String itemId,
    String itemName,
    String itemDescription,
    double itemPrice,
    String itemImageUrl,
    String itemType) async {
  try {
    // Create a new document in the 'items' collection with the specified item ID
    await FirebaseFirestore.instance
        .collection('items')
        .doc(restaurantId)
        .collection('menu')
        .doc(itemId)
        .set({
      'name': itemName,
      'description': itemDescription,
      'price': itemPrice,
      'imageUrl': itemImageUrl,
      'type': itemType, // 'veg' or 'non-veg'
    });
    print(
        'Item added successfully to restaurant ID: $restaurantId with Item ID: $itemId');
  } catch (e) {
    print('Error adding item: $e');
  }
}

Future<void> main() async {
  // Ensure Firebase is initialized
  await Firebase.initializeApp();

  // Get the restaurant ID
  stdout.write('Enter the restaurant ID: ');
  String restaurantId = stdin.readLineSync()!;

  // Get the item ID
  stdout.write('Enter the item ID: ');
  String itemId = stdin.readLineSync()!;

  // Enter item details
  stdout.write('Enter item name: ');
  String itemName = stdin.readLineSync()!;

  stdout.write('Enter item description: ');
  String itemDescription = stdin.readLineSync()!;

  stdout.write('Enter item price: ');
  double itemPrice;
  while (true) {
    String? input = stdin.readLineSync();
    if (input != null && double.tryParse(input) != null) {
      itemPrice = double.parse(input);
      break;
    } else {
      print('Please enter a valid price.');
      stdout.write('Enter item price: ');
    }
  }

  stdout.write('Enter item image URL: ');
  String itemImageUrl = stdin.readLineSync()!;

  stdout.write('Enter item type (veg/non-veg): ');
  String itemType = stdin.readLineSync()!;

  // Validate item type
  while (itemType != 'veg' && itemType != 'non-veg') {
    print('Invalid item type. Please enter "veg" or "non-veg".');
    stdout.write('Enter item type (veg/non-veg): ');
    itemType = stdin.readLineSync()!;
  }

  // Add item to Firestore
  await addItem(restaurantId, itemId, itemName, itemDescription, itemPrice,
      itemImageUrl, itemType);
}
