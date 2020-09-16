import '../../models/admin.dart';
import '../../models/product.dart';
import '../../shared/firebase_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/constants.dart';
import '../../shared/custom_text_field.dart';
import '../../shared/theme.dart';
import '../add_view/add_src.dart';
import 'edit_src.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import 'package:flutter/material.dart';

class EditView extends StatefulWidget {
  static const id = '/edit';
  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  EditSrc _editSrc = EditSrc();
  AddSrc _addSrc = AddSrc();
  final Product _product = Product();
  final Admin _admin = Admin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editSrc.title),
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
                presstoEdit: () {
                  _openConfermationDialoge(
                    context,
                    () async {
                      await _admin.editProduct(
                        context,
                        _nameController.text,
                        _priceController.text,
                        _descriptionController.text,
                        _taxController.text,
                        _data[_product.image],
                        e,
                      );
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
      Function presstoEdit}) {
    return FlatButton(
      onPressed: presstoEdit,
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
      BuildContext context, Function edit) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: SingleChildScrollView(
            child: Column(
              // add text edit controlllers
              children: <Widget>[
                CustomTextField(
                  _addSrc.name,
                  Icons.text_fields,
                  _nameController,
                  TextInputType.text,
                ),
                CustomTextField(
                  _addSrc.description,
                  Icons.description,
                  _descriptionController,
                  TextInputType.text,
                ),
                CustomTextField(
                  _addSrc.price,
                  Icons.monetization_on,
                  _priceController,
                  TextInputType.numberWithOptions(),
                ),
                CustomTextField(
                  _addSrc.tax,
                  Icons.attach_money,
                  _taxController,
                  TextInputType.numberWithOptions(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancle', style: blueGrayTextStyle),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: edit,
              child: Text(
                'Edit',
                style: whiteTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
