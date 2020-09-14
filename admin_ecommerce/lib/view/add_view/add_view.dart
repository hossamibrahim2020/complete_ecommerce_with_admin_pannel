import 'package:flutter/material.dart';

class AddView extends StatelessWidget {
  static const id = '/add';
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
