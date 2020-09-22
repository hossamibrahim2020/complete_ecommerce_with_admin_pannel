import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CountInMoorProvider extends ChangeNotifier {
  int _countInMoor = 1;
  int get countInMoor => _countInMoor;
  
  set setCountInMoor(int number) {
    _countInMoor = number;
  }

  void addOne() {
    _countInMoor++;
    notifyListeners();
  }

  void removeOne(BuildContext context) {
    if (_countInMoor > 1) {
      _countInMoor--;
    } else {
      Toast.show('Can not decrement it', context);
    }
    notifyListeners();
  }

  void returnCountToOne() {
    _countInMoor = 1;
    notifyListeners();
  }
}
