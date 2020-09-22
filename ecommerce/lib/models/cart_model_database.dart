import 'package:moor_flutter/moor_flutter.dart';
part 'cart_model_database.g.dart';

class CartProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Cached image url
  TextColumn get imageUrl => text()();
  TextColumn get name => text()();
  // remove final from generated code
  IntColumn get price => integer()();
  // remove final from generated code
  IntColumn get countOfProduct => integer()();
}

@UseMoor(tables: [CartProducts])
class CartDatabase extends _$CartDatabase {
  CartDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(path: 'cartdb.sqlite'),
        );

  @override
  int get schemaVersion => 1;
  Future insertProductToCart(CartProduct cartProduct) => into(cartProducts).insert(cartProduct);
  Future<List<CartProduct>> getAllProductsFromCart()=> select(cartProducts).get();
  Stream<List<CartProduct>> watchAllProductsInCart()=> select(cartProducts).watch();
  Future updateProductInfo(CartProduct cartProduct)=> update(cartProducts).replace(cartProduct);
  Future deleteProduct(CartProduct cartProduct)=> delete(cartProducts).delete(cartProduct);
}
