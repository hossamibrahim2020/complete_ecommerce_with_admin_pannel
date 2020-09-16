import 'ican_add.dart';
import 'ican_delete.dart';
import 'ican_edit.dart';
import 'ican_vieworder.dart';
import 'base_user.dart';

class Admin extends BaseUser with ICanAdd, ICanEdit, ICanDelete, ICanViewOrder {
  @override
  void viewOrders() 
  {}
}
