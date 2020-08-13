import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class NotesDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    return Container(
      child: FutureBuilder(
        future: notes.getNotes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Consumer<Notes>(
                  builder: (buildContext, noteData, _) {
                    return noteData.notesList.length == 0
                        ? Placeholder('No notes here')
                        : ListView.builder(
                            itemCount: noteData.notesList.length,
                            itemBuilder: (context, i) =>
                                NoteWidget(noteData.notesList[i]));
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
        Container(height: 48, width: 48, child: Image.asset('images/bee.png')),
        SizedBox(height: 10),
        Text(placeHolderText,
            style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 16))
      ],
    );
  }
}
