import 'package:flutter/material.dart';

class AnimatedContainerProvider extends ChangeNotifier {
  double _height = 0;
  double get height => _height;
  void runButton() {
    _height = 70;
    notifyListeners();
  }

  void disposeButton() {
    _height = 0;
    notifyListeners();
  }
}
