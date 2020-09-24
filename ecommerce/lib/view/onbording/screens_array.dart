import 'one_view.dart';
import 'three_view.dart';
import 'two_view.dart';
import 'package:flutter/material.dart';

class ScreensArray {
  final List<Widget> _screens = [
    OneView(),
    TwoView(),
    ThreeView(),
  ];
  List<Widget> get screenArray => _screens;
}
