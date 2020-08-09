import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String content;
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    return Container(
      child: Column(
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
              await notes.addNote(title, content);
              Navigator.of(context).pop(true);
            },
            child: Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
