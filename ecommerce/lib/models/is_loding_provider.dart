import 'package:flutter/material.dart';

class IsLoding extends ChangeNotifier {
  bool isLoding = false;
  void loding() {
    isLoding = true;
    notifyListeners();
  }

  void notLoding() {
    isLoding = false;
    notifyListeners();
  }
}
