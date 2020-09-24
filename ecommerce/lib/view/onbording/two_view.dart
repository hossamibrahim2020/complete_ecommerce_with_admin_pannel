import 'reuseable_onboarding_item.dart';
import 'package:flutter/material.dart';

class TwoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ReusableOnboardingItem(
        imageName: 'assets/addtocart.jpg',
        title: 'ADD To Cart',
        body: 'Add the products that you intend to buy to the basket so that you can shop in a better way',
      ),
    );
  }
}
