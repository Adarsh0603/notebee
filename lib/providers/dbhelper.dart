import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, content TEXT)");
    }, version: 1);
  }

  static Future<void> insertNote(Note note) async {
    final db = await DBHelper.database();
    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateNote(Note note) async {
    final db = await DBHelper.database();

    await db
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<Map<String, dynamic>>> notes() async {
    final db = await DBHelper.database();
    return db.query('notes');
  }

  static Future<void> deleteNoteFromDb(String id) async {
    final db = await DBHelper.database();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
