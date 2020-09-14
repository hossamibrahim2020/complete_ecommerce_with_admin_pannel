import 'package:flutter/material.dart';

class ViewOrdersView extends StatelessWidget {
  static const id = '/viewOrders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
        ],
      ),
    );
  }
}
