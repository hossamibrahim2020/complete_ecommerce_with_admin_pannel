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
  EditSrc _editSrc = EditSrc();
  AddSrc _addSrc = AddSrc();
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
    return GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: <Widget>[
        _item(
          context: context,
          src: 'https://flutter.dev/images/flutter-logo-sharing.png',
          title: 'title',
          price: '231',
          presstoEdit: () {
            _openConfermationDialoge(context, () {
              print('edit');
            });
          },
        ),
      ],
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
                  null,
                  TextInputType.text,
                ),
                CustomTextField(
                  _addSrc.description,
                  Icons.description,
                  null,
                  TextInputType.text,
                ),
                CustomTextField(
                  _addSrc.price,
                  Icons.monetization_on,
                  null,
                  TextInputType.numberWithOptions(),
                ),
                CustomTextField(
                  _addSrc.tax,
                  Icons.attach_money,
                  null,
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
