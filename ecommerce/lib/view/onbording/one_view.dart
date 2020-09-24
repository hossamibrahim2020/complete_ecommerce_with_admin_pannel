import 'reuseable_onboarding_item.dart';
import 'package:flutter/material.dart';

class OneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ReusableOnboardingItem(
        imageName: 'assets/goinshop.jpg',
        title: 'Start Shopping',
        body: 'You can choose between many affordable clothes',
      ),
    );
  }
}
