import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sql/constants.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/note_insert_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NoteWidget extends StatefulWidget {
  final Note note;

  NoteWidget(this.note);

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          open = !open;
        });
      },
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
                      note: widget.note,
                    )
                  ],
                ),
              );
            });
        if (dataMap['title'] != widget.note.title ||
            dataMap['content'] != widget.note.content) {
          await Provider.of<Notes>(context, listen: false).updateNote(Note(
              id: widget.note.id,
              title: dataMap['title'],
              content: dataMap['content']));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(maxRadius: 6, backgroundColor: Colors.green),
                    SizedBox(width: 8.0),
                    Text(widget.note.title, style: kNoteTitleTextStyle),
                    Spacer(),
                    Text(
                        DateFormat('dd.MM.yyyy')
                            .format(DateTime.parse(widget.note.id))
                            .toString(),
                        style: kNoteDateTextStyle),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  widget.note.content,
                  softWrap: true,
                  overflow: open ? TextOverflow.clip : TextOverflow.ellipsis,
                  style: kNoteContentTextStyle,
                ),
              ),
              if (open) SizedBox(height: 8.0),
              if (open) Divider(height: 1),
              if (open)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Double Tap to edit.',
                        style: kNoteDateTextStyle.copyWith(
                            color: Colors.lightBlueAccent),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            await Provider.of<Notes>(context, listen: false)
                                .deleteNote(widget.note.id);
                          },
                          icon: Icon(
                            Icons.delete_outline,
//                              size: 20,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
