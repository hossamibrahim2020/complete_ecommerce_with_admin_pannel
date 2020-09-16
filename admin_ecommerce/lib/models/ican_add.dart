import 'package:toast/toast.dart';
import '../shared/firebase_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'product.dart';

abstract class ICanAdd
{
  final CollectionReference _store = FirebaseFirestore.instance.collection(productCollection);
  final Product _product = Product();
  Future<void> addProduct(BuildContext context, String name, String price, String descriptoin, String tax, String imageUrl) async
  {
    try {
      await _store.add({
        _product.name : name,
        _product.price : price,
        _product.descriptoin : descriptoin,
        _product.tax : tax,
        _product.dateOfPublish : DateTime.now(),
        _product.image : imageUrl,
      });
      Toast.show('Done', context);
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString()),),
      );
      print(e.toString());
    }
  }
}