import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'i_can_order.dart';
import '../view/shared/firebase_keys.dart';

class Order implements ICanOrder{
  final CollectionReference  _order = FirebaseFirestore.instance.collection(orderCollection);
  Future<void> add(BuildContext context){
    
  }
}



// const String orderCollection = 'orderCollection';
// const String userId = 'userId';
// const String productNames = 'productsNames';
// const String userLocation = 'userLocation';
// const String done = 'done';
// const String totalPrice = 'totalPrice';
