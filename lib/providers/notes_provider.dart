import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/dbhelper.dart';

class Notes with ChangeNotifier {
  List<Note> _notesList = [];
  bool _isUpdated = false;

  void setIsUpdated(bool value) {
    _isUpdated = true;
    notifyListeners();
  }

  bool get isUpdated {
    return _isUpdated;
  }

  Future<void> addNote(String title, String content) async {
    Note note = Note(
        id: DateTime.now().toIso8601String(), title: title, content: content);

    await DBHelper.insertNote(note);
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
