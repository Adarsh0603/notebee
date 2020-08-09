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

  static Future<List<Note>> notes() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> noteMaps = await db.query('notes');
    return List.generate(
        noteMaps.length,
        (i) => Note(
            id: noteMaps[i]['id'],
            title: noteMaps[i]['title'],
            content: noteMaps[i]['content']));
  }

  static Future<void> deleteNote(String id) async {
    final db = await DBHelper.database();
    await db.delete('notes', where: 'id=?', whereArgs: [id]);
  }
}
