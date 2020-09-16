import '../../models/admin.dart';
import '../../models/product.dart';
import 'package:adminecommerce/shared/firebase_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/constants.dart';
import '../../shared/theme.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import 'package:flutter/material.dart';
import 'delete_src.dart';

class DeleteView extends StatelessWidget {
  static const id = '/delete';
  final DeleteSrc _deleteSrc = DeleteSrc();
  final Product _product = Product();
  final Admin _admin = Admin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_deleteSrc.title),
      ),
      drawer: ReusableDrawerView(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection(productCollection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        if (snapshot.hasData) {
          return GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: snapshot.data.docs.map((e) {
              final Map<String, dynamic> _data = e.data();
              return _item(
                context: context,
                src: _data[_product.image],
                title: _data[_product.name],
                price: _data[_product.price],
                presstoDelete: () {
                  _openConfermationDialoge(
                    context,
                    () async {
                      await _admin.deleteProduct(e);
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            }).toList(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  FlatButton _item(
      {BuildContext context,
      String src,
      String title,
      String price,
      Function presstoDelete}) {
    return FlatButton(
      onPressed: presstoDelete,
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: Image.network(src),
        footer: Container(
          color: imageColor.withOpacity(.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title),
                Text('$price \$'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openConfermationDialoge(
      BuildContext context, Function delete) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_deleteSrc.title),
          content: Text(_deleteSrc.questoin),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(_deleteSrc.cancle, style: blueGrayTextStyle),
            ),
            FlatButton(
              color: deleteColor,
              onPressed: delete,
              child: Text(
                _deleteSrc.title,
                style: whiteTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
