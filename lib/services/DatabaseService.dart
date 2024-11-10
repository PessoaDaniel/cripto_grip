

// import 'package:sqflite/sqflite.dart' as sqlite;
// import 'package:path/path.dart' as libPath;
class DatabaseService {
  // static Future<sqlite.Database> database() async {
  //   final path  = await sqlite.getDatabasesPath();
  //   return sqlite.openDatabase(
  //     libPath.join(path, 'gripo.db'),
  //     onCreate: (database, version) {
  //         return database.execute('CREATE DATABASE IF NOT EXISTS favorite ('
  //             'id TEXT PRIMARY KEY, '
  //             'api_id TEXT NOT NULL'
  //             ')');
  //     },
  //     version: 1
  //   );
  // }
  // static Future<void> isert(String table, Map<String, dynamic> data) async {
  //   final database = await DatabaseService.database();
  //   await database.insert(table, data, conflictAlgorithm: sqlite.ConflictAlgorithm.replace);
  // }
}