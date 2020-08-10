import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class NotesDisplay extends StatefulWidget {
  @override
  _NotesDisplayState createState() => _NotesDisplayState();
}

class _NotesDisplayState extends State<NotesDisplay> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Notes>(context, listen: false).getNotes();
      setState(() {
        isInit = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    return Container(
      child: FutureBuilder(
        future: notes.getNotes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(notes.notesList.length);
          return snapshot.connectionState == ConnectionState.done
              ? Consumer<Notes>(
                  builder: (buildContext, noteData, _) {
                    return ListView.builder(
                        itemCount: noteData.notesList.length,
                        itemBuilder: (context, i) =>
                            NoteWidget(noteData.notesList[i]));
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
