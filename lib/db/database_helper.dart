import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('horarios_escolares.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Aqui o Flutter cria a tabela automaticamente na primeira execução
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE horarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        disciplina TEXT NOT NULL,
        hora TEXT NOT NULL,
        diaSemana TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('horarios', row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await instance.database;
    return await db.query('horarios');
  }

  Future<int> update(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('horarios', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('horarios', where: 'id = ?', whereArgs: [id]);
  }
}