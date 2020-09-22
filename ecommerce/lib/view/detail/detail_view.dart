import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/cart_model_database.dart';
import '../shared/theme.dart';
import '../../view/detail/count_of_it_provider.dart';
import 'package:provider/provider.dart';
import '../shared/constants.dart';
import '../shared/firebase_keys.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final QueryDocumentSnapshot e;
  // replace it with singletone
  // final CartDatabase _cartDatabase = CartDatabase();

  DetailView(this.e);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      bottomNavigationBar: _addToCartButton(context),
    );
  }

  Widget _body(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(
            '${e.data()[name]}',
            style: tealTextStyle.copyWith(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          expandedHeight: _size.height * .5,
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: '${e.data()[name]}',
              child: Center(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  imageUrl: '${e.data()[image]}',
                ),
              ),
            ),
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // price ,name , description and add to cart
              _namePrice(context),
              _description(context),
              _numberOfProduct(context),
              _freeSpace(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _namePrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${e.data()[name]}',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontFamily: 'hind'),
          ),
          Text(
            '${e.data()[price]} \$',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontFamily: 'hind'),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${e.data()[descriptoin]}',
        style:
            Theme.of(context).textTheme.headline6.copyWith(fontFamily: 'hind'),
      ),
    );
  }

  Widget _numberOfProduct(BuildContext context) {
    final _countProvider = Provider.of<CountOfItProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () {
              _countProvider.addOne();
            },
          ),
          Text(
            '${_countProvider.count}',
            style: Theme.of(context).textTheme.headline5.copyWith(
                color: Theme.of(context).primaryColor, fontFamily: 'hind'),
          ),
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () {
              _countProvider.removeOne(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _freeSpace(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
    );
  }

  Widget _addToCartButton(BuildContext context) {
    final _countProvider = Provider.of<CountOfItProvider>(context);
    return GestureDetector(
      onTap: () {
        // TODO: add to cart complete logic
        Provider.of<CartDatabase>(context ,listen: false).insertProductToCart(
          CartProduct(
            id: Random().nextInt(9000),
            imageUrl: e.data()[image],
            name: e.data()[name],
            price: int.parse(e.data()[price]),
            countOfProduct: _countProvider.count,
          ),
        );
        _countProvider.returnCountToOne();
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: addToCartColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Center(
          child: Text(
            'ADD TO CART'.toUpperCase(),
            style: titleStyle.copyWith(
              fontSize: 26,
            ),
          ),
        ),
      ),
    );
  }
}
