import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../shared/widget/custom_button.dart';
import '../shared/widget/custom_message_sender_field.dart';
import '../shared/theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';
import '../shared/constants.dart';
import '../../models/cart_model_database.dart';
import 'cart_viewmodel.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartViewModel _cartViewModel = CartViewModel();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final Order _order = Order();
  List<String> _productArray = [];
  List<String> _realList = [];
  bool _orderNow = false;
  @override
  void dispose() {
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _orderButton(context),
    );
  }

  Widget _orderButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _orderNow = true;
          });
          _takeUserConfermatoin(context, () {
            _order.add(
              context: context,
              userLocationValue: _locationController.text,
              productNamesAndMuchofitAndpriceOfsigleOne:
                  _realList.toSet().toList(),
              // cartProduct: ,
            );
          });
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              _orderNow = false;
            });
          });
        },
        child: Container(
          child: Center(
            child: Text(
              'ORDER NOW',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: textColor, fontFamily: 'hind'),
            ),
          ),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<List<CartProduct>>(
      stream: _cartViewModel.cartStream(context),
      initialData: [],
      builder:
          (BuildContext context, AsyncSnapshot<List<CartProduct>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Center(child: Text('Error 404'));
        if (snapshot.hasData) return _items(context, snapshot);
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _items(BuildContext context, AsyncSnapshot<List<CartProduct>> snap) {
    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: IntTween(begin: 200, end: 0),
      duration: Duration(seconds: 1),
      builder: (BuildContext context, int value, Widget child) {
        return Transform.translate(
          offset: Offset(value.toDouble(), 0),
          child: TweenAnimationBuilder(
            curve: Curves.ease,
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 2),
            builder: (BuildContext context, double valueOpacity, Widget child) {
              return Opacity(
                opacity: valueOpacity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: snap.data.map((e) {
                        return _singleItem(context, e);
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _singleItem(BuildContext context, CartProduct e) {
    int _countInMoor = e.countOfProduct.toInt();
    if (_orderNow == true) {
      final String _productArrayString =
          '${e.name} $_countInMoor ${e.price * _countInMoor}\$';
      _productArray.add(_productArrayString);
      _realList = _productArray.toSet().toList();
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    _cartViewModel.deleteFromCart(e, context);
                  },
                ),
              ],
              child: ListTile(
                trailing: Text(
                  '${e.price * _countInMoor} \$',
                  style: titleStyle.copyWith(color: Colors.blueGrey),
                ),
                leading: ClipOval(
                  child: Container(
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageUrl: '${e.imageUrl}',
                    ),
                  ),
                ),
                title: Text(
                  '${e.name}',
                  style: titleStyle.copyWith(color: Colors.blueGrey),
                ),
              ),
            ),
            // numer of it
            Padding(
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
                      setState(() {
                        _countInMoor++;
                        _cartViewModel.incressOne(
                            e, e.countOfProduct = _countInMoor, context);
                      });
                    },
                  ),
                  Text(
                    '${e.countOfProduct}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_countInMoor > 1) {
                          _countInMoor--;
                          _cartViewModel.decressOne(
                              e, context, e.countOfProduct = _countInMoor);
                        } else {
                          Toast.show('Can not decrement it', context);
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _takeUserConfermatoin(
    BuildContext context,
    Function order,
  ) {
    return showDialog(
      context: context,
      // user can close it by tap in any place
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Send Feed Back'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          // backgroundColor: Colors.black,
          content: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CustomMessageSenderField(
                    hint: 'YOUR LOCATION',
                    controller: _locationController,
                    icon: Icon(Icons.location_city),
                    textFieldColor: Colors.teal.shade50,
                    textInputType: TextInputType.text,
                  ),
                  CustomRadiusButton(
                    onpress: () {
                      if (_key.currentState.validate()) {
                        order();
                        _locationController.clear();
                        Navigator.of(context).pop();
                        Provider.of<CartDatabase>(context, listen: false)
                            .deleteAllProducts();
                      }
                    },
                    label: 'Send Message',
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
