import 'view_orders_src.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import 'package:flutter/material.dart';

class ViewOrdersView extends StatelessWidget {
  static const id = '/viewOrders';
  final ViewOrdersSrc _viewOrdersSrc = ViewOrdersSrc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewOrdersSrc.title),
      ),
      drawer: ReusableDrawerView(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _item(
            userName: 'user',
            price: '321',
            location: 'almahalla',
            done: () {},
          ),
        ],
      ),
    );
  }

  Widget _item({String userName, String price, String location, Function done}) 
  {
    return ListTile(
      title: Text(userName),
      subtitle: Text('$price \$ $location'),
      trailing: IconButton(
        icon: Icon(
          Icons.check_circle_outline,
        ),
        onPressed: done,
      ),
    );
  }
}
