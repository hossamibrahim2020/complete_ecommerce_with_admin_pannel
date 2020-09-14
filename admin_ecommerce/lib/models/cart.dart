import 'ican_add_to_cart.dart';
import 'ican_delete.dart';
import 'ican_edit_cart.dart';
import 'base_cart.dart';

class Cart extends BaseCart implements ICanAddCart, ICanEditCart, ICanDelete 
{
  @override
  void add() 
  {}

  @override
  void deleteProduct() 
  {}

  @override
  void edit() 
  {}
}
