// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CartProduct extends DataClass implements Insertable<CartProduct> {
  final int id;
  final String imageUrl;
  final String name;
  final int price;
  int countOfProduct;
  CartProduct(
      {@required this.id,
      @required this.imageUrl,
      @required this.name,
      @required this.price,
      @required this.countOfProduct});
  factory CartProduct.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return CartProduct(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      imageUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      countOfProduct: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}count_of_product']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    if (!nullToAbsent || countOfProduct != null) {
      map['count_of_product'] = Variable<int>(countOfProduct);
    }
    return map;
  }

  CartProductsCompanion toCompanion(bool nullToAbsent) {
    return CartProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      countOfProduct: countOfProduct == null && nullToAbsent
          ? const Value.absent()
          : Value(countOfProduct),
    );
  }

  factory CartProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CartProduct(
      id: serializer.fromJson<int>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
      countOfProduct: serializer.fromJson<int>(json['countOfProduct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int>(price),
      'countOfProduct': serializer.toJson<int>(countOfProduct),
    };
  }

  CartProduct copyWith(
          {int id,
          String imageUrl,
          String name,
          int price,
          int countOfProduct}) =>
      CartProduct(
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        name: name ?? this.name,
        price: price ?? this.price,
        countOfProduct: countOfProduct ?? this.countOfProduct,
      );
  @override
  String toString() {
    return (StringBuffer('CartProduct(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('countOfProduct: $countOfProduct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          imageUrl.hashCode,
          $mrjc(
              name.hashCode, $mrjc(price.hashCode, countOfProduct.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CartProduct &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.name == this.name &&
          other.price == this.price &&
          other.countOfProduct == this.countOfProduct);
}

class CartProductsCompanion extends UpdateCompanion<CartProduct> {
  final Value<int> id;
  final Value<String> imageUrl;
  final Value<String> name;
  final Value<int> price;
  final Value<int> countOfProduct;
  const CartProductsCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.countOfProduct = const Value.absent(),
  });
  CartProductsCompanion.insert({
    this.id = const Value.absent(),
    @required String imageUrl,
    @required String name,
    @required int price,
    @required int countOfProduct,
  })  : imageUrl = Value(imageUrl),
        name = Value(name),
        price = Value(price),
        countOfProduct = Value(countOfProduct);
  static Insertable<CartProduct> custom({
    Expression<int> id,
    Expression<String> imageUrl,
    Expression<String> name,
    Expression<int> price,
    Expression<int> countOfProduct,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (countOfProduct != null) 'count_of_product': countOfProduct,
    });
  }

  CartProductsCompanion copyWith(
      {Value<int> id,
      Value<String> imageUrl,
      Value<String> name,
      Value<int> price,
      Value<int> countOfProduct}) {
    return CartProductsCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      countOfProduct: countOfProduct ?? this.countOfProduct,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (countOfProduct.present) {
      map['count_of_product'] = Variable<int>(countOfProduct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartProductsCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('countOfProduct: $countOfProduct')
          ..write(')'))
        .toString();
  }
}

class $CartProductsTable extends CartProducts
    with TableInfo<$CartProductsTable, CartProduct> {
  final GeneratedDatabase _db;
  final String _alias;
  $CartProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  GeneratedTextColumn _imageUrl;
  @override
  GeneratedTextColumn get imageUrl => _imageUrl ??= _constructImageUrl();
  GeneratedTextColumn _constructImageUrl() {
    return GeneratedTextColumn(
      'image_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countOfProductMeta =
      const VerificationMeta('countOfProduct');
  GeneratedIntColumn _countOfProduct;
  @override
  GeneratedIntColumn get countOfProduct =>
      _countOfProduct ??= _constructCountOfProduct();
  GeneratedIntColumn _constructCountOfProduct() {
    return GeneratedIntColumn(
      'count_of_product',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, imageUrl, name, price, countOfProduct];
  @override
  $CartProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'cart_products';
  @override
  final String actualTableName = 'cart_products';
  @override
  VerificationContext validateIntegrity(Insertable<CartProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url'], _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('count_of_product')) {
      context.handle(
          _countOfProductMeta,
          countOfProduct.isAcceptableOrUnknown(
              data['count_of_product'], _countOfProductMeta));
    } else if (isInserting) {
      context.missing(_countOfProductMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartProduct map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CartProduct.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CartProductsTable createAlias(String alias) {
    return $CartProductsTable(_db, alias);
  }
}

abstract class _$CartDatabase extends GeneratedDatabase {
  _$CartDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CartProductsTable _cartProducts;
  $CartProductsTable get cartProducts =>
      _cartProducts ??= $CartProductsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cartProducts];
}
