import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/dbhelper.dart';

class Notes with ChangeNotifier {
  List<Note> _notesList = [];

  Future<void> addNote(String title, String content) async {
    Note note = Note(
        id: DateTime.now().toIso8601String(), title: title, content: content);
    await DBHelper.insertNote(note);
    print('Note added with id:${note.id}');
    await getNotes();
  }

  List<Note> get notesList {
    return [..._notesList];
  }

  Future<void> getNotes() async {
    List<Note> notesFromDatabase = await DBHelper.notes();
    _notesList = notesFromDatabase;
    notifyListeners();
  }
}
