import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CountProvider extends ChangeNotifier {
  int _count = 1;

  void add(BuildContext context, int index) {
    _count++;
    Provider.of<CartProvider>(context, listen: false)
        .updateCount(index, _count);
    notifyListeners();
  }

  void sub(BuildContext context, int index) {
    if (_count > 1) {
      _count--;
      Provider.of<CartProvider>(context, listen: false)
          .updateCount(index, _count);
      notifyListeners();
    }
  }

  int get count => _count;
}
