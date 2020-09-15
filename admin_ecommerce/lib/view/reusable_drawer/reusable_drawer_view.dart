import 'package:flutter/material.dart';
import '../add_view/add_view.dart';
import '../edit_view/edit_view.dart';
import '../delete_view/delete_view.dart';
import '../view_orders.dart/view_orders_view.dart';

class ReusableDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _item(
            context,
            'Add',
            Icons.add,
            () => Navigator.of(context).pushNamedAndRemoveUntil(AddView.id, (route) => false),
          ),
          _item(
            context,
            'Edit',
            Icons.edit,
            () => Navigator.of(context).pushNamedAndRemoveUntil(EditView.id, (route) => false),
          ),
          _item(
            context,
            'Delete',
            Icons.delete,
            () => Navigator.of(context).pushNamedAndRemoveUntil(DeleteView.id, (route) => false),
          ),
          _item(
            context,
            'View Orders',
            Icons.local_offer,
            () => Navigator.of(context).pushNamedAndRemoveUntil(ViewOrdersView.id, (route) => false),
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, String title, IconData icon, Function onTap) 
  {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
