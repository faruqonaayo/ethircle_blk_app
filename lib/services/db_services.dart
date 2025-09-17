import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbServices {
  static Future<Database> get db async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "blk_app.db");

    // deleteDatabase(path);

    var dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE category (id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT, a_value REAL NOT NULL, r_value INTEGER NOT NULL, g_value INTEGER NOT NULL, b_value INTEGER NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)",
        );
        await db.execute(
          "CREATE TABLE item (id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT, worth REAL NOT NULL, address TEXT NOT NULL, image_url TEXT, cat_id TEXT, lat REAL, long REAL, is_favorite BOOL NOT NULL,created_at TEXT NOT NULL, updated_at TEXT NOT NULL, FOREIGN KEY (cat_id) REFERENCES category(id))",
        );
      },
    );
    return dataBase;
  }
}
