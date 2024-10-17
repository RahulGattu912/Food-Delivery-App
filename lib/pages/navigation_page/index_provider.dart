import 'package:flutter/material.dart';

class IndexProvider extends ChangeNotifier {
  int _index = 0;

  IndexProvider({required int initialIndex}) : _index = initialIndex;

  int get index => _index;

  void setIndex(int index) {
    // Check if the index is actually changing
    if (_index != index) {
      _index = index;
      // Ensure that notifyListeners is called after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  set index(int value) {
    if (_index != value) {
      _index = value;
      notifyListeners();
    }
  }
}
