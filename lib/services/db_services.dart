import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbServices {
  static Future<Database> get db async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "blk_app.db");
    var dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE category (id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT, a_value REAL NOT NULL, r_value INTEGER NOT NULL, g_value INTEGER NOT NULL, b_value INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)",
        );
      },
    );

    return dataBase;
  }
}
