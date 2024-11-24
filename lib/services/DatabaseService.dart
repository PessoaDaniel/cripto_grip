

import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as lib_path;
class DatabaseService {
  static Future<sqlite.Database> database() async {
    final path  = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(
      lib_path.join(path, 'grip.db'),
      onCreate: (database, version) {
          return database.execute('CREATE TABLE IF NOT EXISTS favorite ('
              'id TEXT PRIMARY KEY, '
              'api_id TEXT NOT NULL'
              ')');
      },
      version: 1
    );
  }
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final database = await DatabaseService.database();
    await database.insert(table, data, conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
  }
  static Future<List<Map<String, Object?>>> findAll(String table) async {
    final database = await DatabaseService.database();
    return await database.rawQuery("SELECT * FROM $table");
  }
  static Future<void> removeOne(String table, String coinId) async {
    final database = await DatabaseService.database();
    await database.execute("DELETE FROM $table WHERE api_id = '$coinId'");
  }
}