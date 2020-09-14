import 'package:flutter/material.dart';

class EditView extends StatelessWidget {
  static const id = '/edit';
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
