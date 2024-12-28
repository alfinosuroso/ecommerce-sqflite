import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/services/database/db_helper.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';

class ProductDao {
  final DBHelper dbProvider;

  ProductDao([DBHelper? dbProvider])
      : dbProvider = dbProvider ?? DBHelper.dbProvider;

  Future<bool> insertProduct(Product product) async {
    final db = await dbProvider.database;
    final insertResult =
        await db.insert(ProductTable.PRODUCTS_TABLE, product.toMap());
    return insertResult != 0;
  }

  // BUYER
  Future<List<Product>> getProducts() async {
    final db = await dbProvider.database;
    final result = await db.query(ProductTable.PRODUCTS_TABLE);
    List<Product> products = result.isNotEmpty
        ? result.map((row) => Product.fromMap(row)).toList()
        : [];
    return products;
  }

  // SELLER
  Future<List<Product>> getProductsBySellerId(int sellerId) async {
    final db = await dbProvider.database;
    final result = await db.query(ProductTable.PRODUCTS_TABLE,
        where: '${ProductTable.PRODUCTS_SELLER_ID} = ?', whereArgs: [sellerId]);
    List<Product> products = result.isNotEmpty
        ? result.map((row) => Product.fromMap(row)).toList()
        : [];
    return products;
  }

  Future<Product> getProductById(int productId) async {
    final db = await dbProvider.database;
    final result = await db.query(ProductTable.PRODUCTS_TABLE,
        where: '${ProductTable.PRODUCTS_ID} = ?', whereArgs: [productId]);
    List<Product> products = result.isNotEmpty
        ? result.map((row) => Product.fromMap(row)).toList()
        : [];
    return products.isNotEmpty ? products[0] : Product.empty();
  }

  Future<bool> updateProduct(Product product) async {
    final db = await dbProvider.database;
    final result = await db.update(ProductTable.PRODUCTS_TABLE, product.toMap(),
        where: '${ProductTable.PRODUCTS_ID} = ?', whereArgs: [product.id]);
    return result != 0;
  }

  Future<bool> deleteProduct(int productId) async {
    final db = await dbProvider.database;
    final result = await db.delete(ProductTable.PRODUCTS_TABLE,
        where: '${ProductTable.PRODUCTS_ID} = ?', whereArgs: [productId]);
    return result != 0;
  }
}
