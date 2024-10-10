import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<List<dynamic>> currentOrder = [];
  List<List<dynamic>> completedOrders = [];
  List<List<dynamic>> cancelledOrders = [];

  int currentOrderIndex = -1;
  int completedOrderIndex = -1;
  int cancelledOrderIndex = -1;

  double deliveryCharge = 0;
  double packagingCharge = 40;
  double tax = 18.20;
  double coupon = 182.06;

  void addCurrentOrder({
    required String name,
    required String restaurant,
    required bool type,
    required String cost,
    required String address,
    required int count,
  }) {
    currentOrderIndex++;
    currentOrder.add([]);
    currentOrder[currentOrderIndex].add(name);
    currentOrder[currentOrderIndex].add(restaurant);
    currentOrder[currentOrderIndex].add(type);
    currentOrder[currentOrderIndex].add(cost);
    currentOrder[currentOrderIndex].add(address);
    currentOrder[currentOrderIndex].add(count);
    notifyListeners();
  }

  double totalCost() {
    double sum = deliveryCharge + packagingCharge + tax - coupon;
    for (int i = 0; i < currentOrder.length; i++) {
      double itemCost = double.parse(currentOrder[i][3]);
      int itemCount = currentOrder[i][5];
      sum += itemCost * itemCount;
    }
    return sum;
  }

  // void addCompletedOrders({
  //   required String name,
  //   required String restaurant,
  //   required String type,
  //   required String cost,
  //   required String address,
  // }) {
  //   completedOrderIndex++;
  //   completedOrders.add([]);
  //   completedOrders[completedOrderIndex].add(name);
  //   completedOrders[completedOrderIndex].add(restaurant);
  //   completedOrders[completedOrderIndex].add(type);
  //   completedOrders[completedOrderIndex].add(cost);
  //   completedOrders[completedOrderIndex].add(address);
  //   notifyListeners();
  // }

  // void addCancelledOrders({
  //   required String name,
  //   required String restaurant,
  //   required String type,
  //   required String cost,
  //   required String address,
  // }) {
  //   cancelledOrderIndex++;
  //   cancelledOrders.add([]);
  //   cancelledOrders[cancelledOrderIndex].add(name);
  //   cancelledOrders[cancelledOrderIndex].add(restaurant);
  //   cancelledOrders[cancelledOrderIndex].add(type);
  //   cancelledOrders[cancelledOrderIndex].add(cost);
  //   cancelledOrders[cancelledOrderIndex].add(address);
  //   notifyListeners();
  // }
}
