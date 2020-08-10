import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sql/constants.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_insert_widget.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatelessWidget {
  final Note note;

  NoteWidget(this.note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        var dataMap = await showDialog<Map<String, dynamic>>(
            barrierColor: Colors.white70,
            context: context,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  children: [
                    AddNote(
                      note: note,
                    )
                  ],
                ),
              );
            });
        if (dataMap['title'] != note.title ||
            dataMap['content'] != note.content) {
          await Provider.of<Notes>(context, listen: false).updateNote(Note(
              id: note.id,
              title: dataMap['title'],
              content: dataMap['content']));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Dismissible(
          key: ValueKey(note.id),
          background: Container(
            color: Colors.black,
            child: Icon(Icons.delete),
          ),
          onDismissed: (_) async {
            await Provider.of<Notes>(context, listen: false)
                .deleteNote(note.id);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.2),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(note.title, style: kNoteTitleTextStyle),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Text(
                    note.content,
                    softWrap: true,
                    style: kNoteContentTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
