import 'ican_delete_from_cart.dart';
import 'ican_add_to_cart.dart';
import 'ican_edit_cart.dart';
import 'base_cart.dart';

class Cart extends BaseCart implements ICanAddCart, ICanEditCart, ICanDeleteFromCart 
{
  @override
  void add() 
  {}

  @override
  void edit() 
  {}

  @override
  void deleteProduct()
  {}
}
