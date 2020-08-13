import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
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
    final notes = Provider.of<Notes>(context, listen: false);
    return Container(
      child: FutureBuilder(
        future: notes.getNotes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? FutureBuilder(
                  future:
                      Provider.of<Labels>(context, listen: false).getLabels(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? Consumer<Notes>(
                            builder: (buildContext, noteData, _) {
                              return noteData.notesList.length == 0
                                  ? Placeholder('No Notes Found')
                                  : ListView.builder(
                                      itemCount: noteData.notesList.length,
                                      itemBuilder: (context, i) => NoteWidget(
                                          noteData.notesList[i],
                                          ValueKey(noteData.notesList[i].id)));
                            },
                          )
                        : Placeholder('Getting notes...');
                  },
                )
              : Placeholder('Getting notes...');
        },
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  final String placeHolderText;

  Placeholder(this.placeHolderText);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(placeHolderText,
            style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        SizedBox(height: 5),
        if (placeHolderText.contains('Found'))
          Text('Add some notes\nor search in another label',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                  fontSize: 12)),
      ],
    );
  }
}
