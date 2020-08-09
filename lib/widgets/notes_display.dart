import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class NotesDisplay extends StatefulWidget {
  @override
  _NotesDisplayState createState() => _NotesDisplayState();
}

class _NotesDisplayState extends State<NotesDisplay> {
  var notes;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInit) {
      notes = Provider.of<Notes>(context, listen: false);
      Future.delayed(Duration.zero).then((_) async {
        await notes.getNotes();
        setState(() {
          isInit = false;
        });
      });
    }
  }

  void deleteNote() async {
    await notes.getNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notes.getNotes(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print(snapshot.connectionState);
        return snapshot.connectionState == ConnectionState.done
            ? ListView.builder(
                itemCount: notes.notesList.length,
                itemBuilder: (context, i) =>
                    NoteWidget(notes.notesList[i], deleteNote))
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
