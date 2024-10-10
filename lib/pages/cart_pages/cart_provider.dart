import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<List<dynamic>> cart = [];
  int index = -1;
  int count = 1;

  double deliveryCharge = 0;
  double packagingCharge = 40;
  double tax = 18.20;
  double coupon = 182.06;
  void add(
      {required String restaurantName,
      required String address,
      required String itemName,
      required String img,
      required String cost,
      required bool type}) {
    index++;
    cart.add([]);
    cart[index].add(restaurantName);
    cart[index].add(address);
    cart[index].add(itemName);
    cart[index].add(img);
    cart[index].add(cost);
    cart[index].add(count);
    cart[index].add(type);
    //print(cart);
    notifyListeners();
  }

  void updateCount(int index, int count) {
    cart[index][5] = count;
    notifyListeners();
  }

  double totalCost() {
    double sum = deliveryCharge + packagingCharge + tax - coupon;
    for (int i = 0; i < cart.length; i++) {
      double itemCost = double.parse(cart[i][4]);
      int itemCount = cart[i][5];
      sum += itemCost * itemCount;
    }
    return sum;
  }

  void reset() {
    index = -1;
    cart.clear();
    notifyListeners();
  }
}
