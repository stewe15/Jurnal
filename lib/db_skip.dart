import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Skip.dart';
import 'package:path_provider/path_provider.dart';

class DbSkip {
  static final DbSkip _instance = DbSkip._internal();
  factory DbSkip() => _instance;

  static Database? _database;

  DbSkip._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'skip_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE skip(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        time_of TEXT NOT NULL,
        nm TEXT NOT NULL

      )
    ''');
  }

  Future<void> insertUser(Skip user) async {
    final db = await database;
    await db.insert(
      'skip',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Skip>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('skip');

    return List.generate(maps.length, (i) {
      return Skip.fromMap(maps[i]);
    });
  }

  Future<void> updateUser(Skip user) async {
    final db = await database;
    await db.update(
      'skip',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'skip',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
