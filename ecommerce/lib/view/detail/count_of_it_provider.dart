import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CountOfItProvider extends ChangeNotifier {
  int _count = 1;
  int get count => _count;
  void addOne() {
    _count++;
    notifyListeners();
  }

  void removeOne(BuildContext context) {
    if (_count > 0) {
      _count--;
    } else {
      Toast.show('Can not decrement it', context);
    }
    notifyListeners();
  }
}
