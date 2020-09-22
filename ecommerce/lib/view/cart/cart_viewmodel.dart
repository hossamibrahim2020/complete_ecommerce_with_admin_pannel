import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../../models/cart_model_database.dart';
import 'package:provider/provider.dart';

class CartViewModel {
  Stream cartStream(BuildContext context) {
    // Singleton Design pattern
    return Provider.of<CartDatabase>(context,listen: false).watchAllProductsInCart();
  }

  void deleteFromCart(CartProduct cartProduct, BuildContext context) {
    Provider.of<CartDatabase>(context,listen: false).deleteProduct(cartProduct);
  }

  void incressOne(CartProduct e, int countOfProduct, BuildContext context) {
    Provider.of<CartDatabase>(context,listen: false).updateProductInfo(
      CartProduct(
        id: e.id,
        imageUrl: e.imageUrl,
        name: e.name,
        price: e.price,
        countOfProduct: countOfProduct,
      ),
    );
  }

  void decressOne(CartProduct e, BuildContext context, int countOfProduct) {
    if (e.countOfProduct > 0) {
      Provider.of<CartDatabase>(context,listen: false).updateProductInfo(
        CartProduct(
          id: e.id,
          imageUrl: e.imageUrl,
          name: e.name,
          price: e.price,
          countOfProduct: countOfProduct,
        ),
      );
    } else {
      Toast.show('Cannot Decress it', context);
    }
  }
}
