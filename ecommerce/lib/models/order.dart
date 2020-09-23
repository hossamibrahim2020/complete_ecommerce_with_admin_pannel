import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'i_can_order.dart';
import '../view/shared/firebase_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Order implements ICanOrder {
  String _userIdValue = FirebaseAuth.instance.currentUser.uid;
  final _order = FirebaseFirestore.instance.collection(orderCollection);
  void add({
    @required BuildContext context,
    @required String userLocationValue,
    @required List productNamesAndMuchofitAndpriceOfsigleOne,
    // @required CartProduct cartProduct,
  }) async {
    try {
      await _order.add({
        userLocation: userLocationValue,
        productNames: productNamesAndMuchofitAndpriceOfsigleOne,
        userId: this._userIdValue,
      });
      // Provider.of<CartDatabase>(context, listen: false)
      //     .deleteProduct(cartProduct);
    } on PlatformException catch (e) {
      Toast.show('${e.message}', context);
    }
  }
}
