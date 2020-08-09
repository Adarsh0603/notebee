import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_insert_widget.dart';
import 'package:flutter_database_sql/widgets/notes_display.dart';
import 'package:provider/provider.dart';

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
          var dataMap = await showDialog<Map<String, dynamic>>(
              barrierColor: Colors.white70,
              context: context,
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    children: [AddNote()],
                  ),
                );
              });
          if (dataMap['title'] != null && dataMap['content'] != null) {
            await Provider.of<Notes>(context, listen: false)
                .addNote(dataMap['title'], dataMap['content']);
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
