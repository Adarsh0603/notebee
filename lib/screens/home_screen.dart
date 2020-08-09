import 'package:flutter/material.dart';
import 'package:flutter_database_sql/widgets/note_insert_widget.dart';
import 'package:flutter_database_sql/widgets/notes_display.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await showDialog<bool>(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Add Note'),
                  children: [AddNote()],
                );
              });
          if (result) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('NotesApp'),
      ),
      body: NotesDisplay(),
    );
  }
}
