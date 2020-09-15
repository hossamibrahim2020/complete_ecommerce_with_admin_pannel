import '../../shared/theme.dart';
import '../../shared/custom_text_field.dart';
import 'add_src.dart';
import 'package:flutter/material.dart';
import '../reusable_drawer/reusable_drawer_view.dart';
import '../../shared/custom_button.dart';

class AddView extends StatefulWidget {
  static const id = '/add';
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  AddSrc _addSrc = AddSrc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_addSrc.title),
      ),
      drawer: ReusableDrawerView(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
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
          // Image
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Container(
              height: _size.height * .3,
              width: _size.height * .2,
              decoration: BoxDecoration(
                color: imageColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  size: 40,
                  color: Colors.blueGrey,
                ),
                onPressed: () {},
              ),
            ),
          ),
          CustomButton(
            _addSrc.title,
            () {},
          ),
        ],
      ),
    );
  }
}
