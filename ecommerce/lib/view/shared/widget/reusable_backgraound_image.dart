import 'package:flutter/material.dart';

class ReusbableBackGraoundImage extends StatelessWidget {
  final Widget child;
  const ReusbableBackGraoundImage(this.child);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/cover.jpg',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        child,
      ],
    );
  }
}
