import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, content TEXT,date TEXT,labelId TEXT)");
      await db.execute(
          "CREATE TABLE labels(id TEXT PRIMARY KEY, label TEXT, color INTEGER)");
    }, version: 1);
  }

  static Future<void> insert(String tableName, Map data) async {
    final db = await DBHelper.database();
    await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> update(String tableName, Map data) async {
    final db = await DBHelper.database();

    await db.update(tableName, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  static Future<List<Map<String, dynamic>>> getDataFromTable(
      String tableName) async {
    final db = await DBHelper.database();
    return db.query(tableName);
  }

  static Future<void> deleteDataFromDb(String tableName, String id) async {
    final db = await DBHelper.database();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
