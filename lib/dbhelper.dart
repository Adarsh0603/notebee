import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/note.dart';

class DBHelper {
  Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)");
    }, version: 1);
  }

  Future<void> insertNote(Note note) async {
    final db = await database();
    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Note>> notes() async {
    final db = await database();
    final List<Map<String, dynamic>> noteMaps = await db.query('notes');
    return List.generate(
        noteMaps.length,
        (i) => Note(
            id: noteMaps[i]['id'],
            title: noteMaps[i]['title'],
            content: noteMaps[i]['content']));
  }
}
