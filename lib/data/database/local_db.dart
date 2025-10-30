import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Singleton class to manage local database
class LocalDb {
  static final LocalDb _instance = LocalDb._internal();
  factory LocalDb() => _instance;
  LocalDb._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'blk_database.db');
    // deleteDatabase(path); // For development purposes; remove in production
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: _onOpen,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE inventories (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        type TEXT,
        use TEXT,
        rColor INTEGER,
        gColor INTEGER,
        bColor INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE items (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        measureUnit TEXT,
        measurementValue REAL,
        pricePerUnit REAL,
        inventoryId TEXT,
        FOREIGN KEY (inventoryId) REFERENCES inventories (id)
      )
    ''');
  }

  Future<void> _onOpen(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS inventories (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        type TEXT,
        use TEXT,
        rColor INTEGER,
        gColor INTEGER,
        bColor INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS items (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        measureUnit TEXT,
        measurementValue REAL,
        pricePerUnit REAL,
        inventoryId TEXT,
        FOREIGN KEY (inventoryId) REFERENCES inventories (id) 
      )
    ''');
  }
}
