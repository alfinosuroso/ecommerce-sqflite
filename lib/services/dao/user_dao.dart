import 'dart:async';

import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/database/db_helper.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';

class UserDao {
  final DBHelper dbProvider;

  UserDao([DBHelper? dbProvider])
      : dbProvider = dbProvider ?? DBHelper.dbProvider;

  Future<User> getUser(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(UserTable.USERS_TABLE,
        where: '${UserTable.USERS_ID} = ?', whereArgs: [id]);

    List<User> userModel = result.isNotEmpty
        ? result.map((row) => User.fromMap(row)).toList()
        : [];
    return userModel.isNotEmpty ? userModel[0] : const User.empty();
  }

  Future<User> verifyUserCredential(String email, String password) async {
    final db = await dbProvider.database;
    final result = await db.query(
      UserTable.USERS_TABLE,
      where: '${UserTable.USERS_EMAIL} = ? AND ${UserTable.USERS_PASSWORD} = ?',
      whereArgs: [email, password],
    );

    List<User> userModel = result.isNotEmpty
        ? result.map((row) => User.fromMap(row)).toList()
        : [];
    return userModel.isNotEmpty ? userModel[0] : const User.empty();
  }

  Future<bool> insertUser(User user) async {
    final db = await dbProvider.database;

    final result = await db.query(
      UserTable.USERS_TABLE,
      where: '${UserTable.USERS_EMAIL} = ?',
      whereArgs: [user.email],
    );

    if (result.isNotEmpty) {
      return false;
    }

    final insertResult = await db.insert(UserTable.USERS_TABLE, user.toMap());
    return insertResult != 0;
  }

  Future<bool> updateUser(User user) async {
    final db = await dbProvider.database;
    final result = await db.update(UserTable.USERS_TABLE, user.toMap(),
        where: '${UserTable.USERS_ID} = ?', whereArgs: [user.id]);
    return result != 0;
  }

  Future<bool> deleteUser(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(UserTable.USERS_TABLE,
        where: '${UserTable.USERS_ID} = ?', whereArgs: [id]);
    return result != 0;
  }
}
