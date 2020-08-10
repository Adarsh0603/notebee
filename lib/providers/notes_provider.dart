import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/dbhelper.dart';

class Notes with ChangeNotifier {
  List<Note> _notesList = [];

  Future<void> addNote(String title, String content) async {
    Note note = Note(
        id: DateTime.now().toIso8601String(), title: title, content: content);
    _notesList.add(note);
    notifyListeners();

    await DBHelper.insertNote(note);
  }

  List<Note> get notesList {
    return [..._notesList].reversed.toList();
  }

  Future<void> deleteNote(String id) async {
    _notesList.removeWhere((element) => element.id == id);
    notifyListeners();
    await DBHelper.deleteNoteFromDb(id);
  }

  Future<void> getNotes() async {
    List<Map<String, dynamic>> notesFromDatabase = await DBHelper.notes();
    _notesList = notesFromDatabase.map((item) =>
        Note(id: item['id'], title: item['title'], content: item['content']));
    notifyListeners();
  }
}
