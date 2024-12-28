import 'package:sqflite/sqflite.dart';

class UserTable {
  static const String USERS_TABLE = 'users';
  static const String USERS_ID = 'id';
  static const String USERS_NAME = 'username';
  static const String USERS_EMAIL = 'email';
  static const String USERS_PASSWORD = 'password';
  static const String USERS_ROLE = 'role';

  static void createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $USERS_TABLE (
        $USERS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $USERS_NAME TEXT NOT NULL,
        $USERS_EMAIL TEXT NOT NULL,
        $USERS_PASSWORD TEXT NOT NULL,
        $USERS_ROLE TEXT NOT NULL
      )
    ''');
  }
}
