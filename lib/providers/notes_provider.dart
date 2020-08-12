import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/dbhelper.dart';

class Notes with ChangeNotifier {
  List<Note> _notesList = [];
  var allNotesList;
  List<Note> _searchedNotesList = [];

  Future<void> addNote(String title, String content, String labelId) async {
    Note note = Note(
        id: DateTime.now().toIso8601String(),
        title: title,
        content: content,
        labelId: labelId);
    _notesList.add(note);
    notifyListeners();

    await DBHelper.insert('notes', note.toMap());
  }

  List<Note> get notesList {
    return [..._notesList].reversed.toList();
  }

  Future<void> deleteNote(String id) async {
    _notesList.removeWhere((element) => element.id == id);
    notifyListeners();

    await DBHelper.deleteDataFromDb('notes', id);
  }

  Future<void> updateNote(Note note) async {
    int updateIndex = _notesList.indexWhere((element) => element.id == note.id);

    _notesList[updateIndex] = note;
    notifyListeners();

    await DBHelper.update('notes', note.toMap());
  }

  Future<void> getNotes() async {
    List<Map<String, dynamic>> notesFromDatabase =
        await DBHelper.getDataFromTable('notes');
    _notesList = notesFromDatabase
        .map((item) => Note(
            id: item['id'],
            title: item['title'],
            content: item['content'],
            labelId: item['labelId']))
        .toList();
    allNotesList = [..._notesList];
    notifyListeners();
  }

  //SEARCH FUNCTIONALITY

  void getAndSetSearchedNotesList(String searchTerm) {
    _notesList = allNotesList;
    _notesList = _notesList
        .where((element) =>
            element.title.contains(searchTerm) ||
            element.content.contains(searchTerm))
        .toList();
    notifyListeners();
  }

  void getAndSetSearchedNotesListWithLabel(String labelId) {
    _notesList = allNotesList;
    if (labelId != 'all')
      _notesList =
          _notesList.where((element) => element.labelId == labelId).toList();
    notifyListeners();
  }
}
