import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class NotesDisplay extends StatefulWidget {
  @override
  _NotesDisplayState createState() => _NotesDisplayState();
}

class _NotesDisplayState extends State<NotesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<Notes>(
        builder: (BuildContext context, notes, _) {
          return FutureBuilder(
            future: notes.getNotes(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              print(snapshot.connectionState);
              return snapshot.connectionState == ConnectionState.done
                  ? ListView.builder(
                      itemCount: notes.notesList.length,
                      itemBuilder: (context, i) =>
                          NoteWidget(notes.notesList[i]))
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          );
        },
      ),
    );
  }
}
