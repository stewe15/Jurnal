import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'TimeT.dart';
import 'package:path_provider/path_provider.dart';
class DbPara {
  static final DbPara _instance = DbPara._internal();
  factory DbPara() => _instance;

  static Database? _database;

  DbPara._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'para_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE para(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        audit TEXT NOT NULL,
        paraGroup TEXT NOT NULL,
        dayOfWeek TEXT NOT NULL,
        Time TEXT NOT NULL,
        week TEXT NOT NULL

      )
    ''');
  }

  Future<void> insertUser(Para user) async {
    final db = await database;
    await db.insert(
      'para',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Para>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('para');

    return List.generate(maps.length, (i) {
      return Para.fromMap(maps[i]);
    });
  }

  Future<void> updateUser(Para user) async {
    final db = await database;
    await db.update(
      'para',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'para',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
