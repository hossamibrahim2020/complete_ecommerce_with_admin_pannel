import '../../models/order.dart';
import 'package:adminecommerce/shared/firebase_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'view_orders_src.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import 'package:flutter/material.dart';

class ViewOrdersView extends StatelessWidget {
  static const id = '/viewOrders';
  final ViewOrdersSrc _viewOrdersSrc = ViewOrdersSrc();
  final Order _order = Order();
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(orderCollection)
          .orderBy(_order.done, descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.docs.map((e) {
              final Map<String, dynamic> _data = e.data();
              return _item(
                userName: _data[_order.userId],
                price: _data[_order.totalPrice],
                location: _data[_order.userLocation],
                done: () {
                  FirebaseFirestore.instance
                      .collection(orderCollection)
                      .doc(e.id)
                      .set({
                    _order.userId: _data[_order.userId],
                    _order.totalPrice: _data[_order.totalPrice],
                    _order.userLocation: _data[_order.userLocation],
                    _order.done: _data[_order.done] == true ? false : true,
                  });
                },
                doneValue: _data[_order.done],
              );
            }).toList(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _item({
    String userName,
    String price,
    String location,
    Function done,
    bool doneValue,
  }) {
    return ListTile(
      title: Text(userName),
      subtitle: Text('$price \$ $location'),
      trailing: IconButton(
        icon: Icon(
          Icons.check_circle_outline,
          color: doneValue == true ? Colors.teal : Colors.blueGrey,
        ),
        onPressed: () {
          done();
        },
      ),
    );
  }
}
