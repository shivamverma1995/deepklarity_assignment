import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/productListModel.dart';

Future<Database> initDB() async {
  Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'product_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE products(productName TEXT PRIMARY KEY,productURL TEXT, productRating DOUBLE, productDescription TEXT)',
      );
    },
    version: 1,
  );
  return database;
}

Future<void> insertProductIntoDB(
    Future<Database> database, Product product) async {
  final db = await database;

  // Insert the product into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same product is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'products',
    product.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Product>> getProductsFromDB() async {
  final db = await initDB();

  final List<Map<String, dynamic>> maps = await db.query('products');

  return List.generate(maps.length, (i) {
    return Product.fromMap(maps[i]);
  });
}
