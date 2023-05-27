import 'package:sqflite/sqflite.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = "TODO_LIST_PROVIDER";
  static SqliteConnectionFactory? _instance;

  Database? db;

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    if (_instance == null) {
      _instance == SqliteConnectionFactory._();
    }

    return _instance!;
  }

  /*Future<Database> openConnection() async {
    await 
  }*/
}
