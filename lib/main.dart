import 'package:flutter/material.dart';
import 'package:flutter_database_sql/dbhelper.dart';
import 'package:flutter_database_sql/models/note.dart';

void main() {
  runApp(DatabaseFlutterApp());
}

class DatabaseFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      title: 'DatabaseFlutter',
    );
  }
}

class HomePage extends StatelessWidget {
  var title;
  var content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotesApp'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Title'),
            onChanged: (value) {
              title = value;
              print(title);
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Content'),
            onChanged: (value) {
              content = value;
            },
          ),
          FlatButton(
            onPressed: () async {
              List notes = await DBHelper().notes();

              Note note =
                  Note(id: notes.length + 1, title: title, content: content);
              await DBHelper().insertNote(note);
              print('Note added with id:${note.id}');
            },
            child: Text('Save Note'),
          )
        ],
      ),
    );
  }
}
