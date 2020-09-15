import '../../shared/constants.dart';
import '../../shared/theme.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import 'package:flutter/material.dart';
import 'delete_src.dart';

class DeleteView extends StatelessWidget {
  static const id = '/delete';
  final DeleteSrc _deleteSrc = DeleteSrc();
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
    return GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: <Widget>[
        _item(
          context: context,
          src: 'https://flutter.dev/images/flutter-logo-sharing.png',
          title: 'title',
          price: '231',
          presstoDelete: () {
            _openConfermationDialoge(
              context,
              () {
                print('delete');
              },
            );
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
          title: Text('Delete'),
          content: Text('Are You Sure?!!'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancle', style: blueGrayTextStyle),
            ),
            FlatButton(
              color: deleteColor,
              onPressed: delete,
              child: Text(
                'Delete',
                style: whiteTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
