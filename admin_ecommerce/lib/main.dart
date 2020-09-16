import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/add_view/add_view.dart';
import 'shared/theme.dart';
import 'view/delete_view/delete_view.dart';
import 'view/edit_view/edit_view.dart';
import 'view/view_orders.dart/view_orders_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      theme: theme,
      routes: {
        AddView.id: (context) => AddView(),
        EditView.id: (context) => EditView(),
        DeleteView.id: (context) => DeleteView(),
        ViewOrdersView.id: (context) => ViewOrdersView(),
      },
      initialRoute: AddView.id,
    );
  }
}
