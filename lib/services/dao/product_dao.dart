import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/services/database/db_helper.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';

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
  // Future<List<Product>> getProducts() async {
  //   final db = await dbProvider.database;
  //   final result = await db.query(ProductTable.PRODUCTS_TABLE);
  //   List<Product> products = result.isNotEmpty
  //       ? result.map((row) => Product.fromMap(row)).toList()
  //       : [];
  //   return products;
  // }

  // SELLER
  // Future<List<Product>> getProductsByUserId(int userId) async {
  //   final db = await dbProvider.database;
  //   final result = await db.query(ProductTable.PRODUCTS_TABLE,
  //       where: '${ProductTable.PRODUCTS_USER_ID} = ?', whereArgs: [userId]);
  //   List<Product> products = result.isNotEmpty
  //       ? result.map((row) => Product.fromMap(row)).toList()
  //       : [];
  //   return products;
  // }

  // Future<Product> getProductById(int productId) async {
  //   final db = await dbProvider.database;
  //   final result = await db.query(ProductTable.PRODUCTS_TABLE,
  //       where: '${ProductTable.PRODUCTS_ID} = ?', whereArgs: [productId]);
  //   List<Product> products = result.isNotEmpty
  //       ? result.map((row) => Product.fromMap(row)).toList()
  //       : [];
  //   return products.isNotEmpty ? products[0] : Product.empty();
  // }

  Future<List<ProductDetail>> getAllProductDetails() async {
    final db = await dbProvider.database;

    final result = await db.rawQuery('''
    SELECT 
      p.id AS product_id, 
      p.name AS product_name,
      p.description AS product_description,
      p.image AS product_image,
      p.price AS product_price,
      p.stock AS product_stock,
      p.userId AS user_id,
      u.id AS user_id, 
      u.username AS user_username, 
      u.email AS user_email, 
      u.role AS user_role
    FROM ${ProductTable.PRODUCTS_TABLE} p
    INNER JOIN ${UserTable.USERS_TABLE} u
    ON p.${ProductTable.PRODUCTS_USER_ID} = u.${UserTable.USERS_ID}
  ''');

    return result.map((row) => ProductDetail.fromQueryRow(row)).toList();
  }

  Future<ProductDetail> getProductDetailById(int productId) async {
    final db = await dbProvider.database;

    final result = await db.rawQuery('''
    SELECT 
      p.id AS product_id, 
      p.name AS product_name,
      p.description AS product_description,
      p.image AS product_image,
      p.price AS product_price,
      p.stock AS product_stock,
      p.userId AS user_id,
      u.id AS user_id, 
      u.username AS user_username, 
      u.email AS user_email, 
      u.role AS user_role
    FROM ${ProductTable.PRODUCTS_TABLE} p
    INNER JOIN ${UserTable.USERS_TABLE} u
    ON p.${ProductTable.PRODUCTS_USER_ID} = u.${UserTable.USERS_ID}
    WHERE p.${ProductTable.PRODUCTS_ID} = ?
  ''', [productId]);

    List<ProductDetail> productDetail = result.isNotEmpty
        ? result.map((row) => ProductDetail.fromQueryRow(row)).toList()
        : [];
    return productDetail.isNotEmpty ? productDetail[0] : ProductDetail.empty();
  }

  Future<List<ProductDetail>> getProductsByUserId(int userId) async {
    final db = await dbProvider.database;

    final result = await db.rawQuery('''
    SELECT 
      p.id AS product_id, 
      p.name AS product_name,
      p.description AS product_description,
      p.image AS product_image,
      p.price AS product_price,
      p.stock AS product_stock,
      p.userId AS user_id,
      u.id AS user_id, 
      u.username AS user_username, 
      u.email AS user_email, 
      u.role AS user_role
    FROM ${ProductTable.PRODUCTS_TABLE} p
    INNER JOIN ${UserTable.USERS_TABLE} u
    ON p.${ProductTable.PRODUCTS_USER_ID} = u.${UserTable.USERS_ID}
    WHERE p.${ProductTable.PRODUCTS_USER_ID} = ?
  ''', [userId]);

    return result.map((row) => ProductDetail.fromQueryRow(row)).toList();
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
