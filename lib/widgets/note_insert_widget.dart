import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/constants.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  final Note note;
  AddNote({this.note});

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String content;
  String labelId;
  int labelColor = 0xffffff;
  Future<bool> saveNote() async {
    Navigator.of(context).pop({'title': title, 'content': content});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      title = widget.note.title;
      content = widget.note.content;
    }
    return WillPopScope(
      onWillPop: saveNote,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                    onTap: () {
                      Navigator.pop(
                          context, {'title': title, 'content': content});
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: title,
                            maxLines: 1,
                            style: kAddNoteTitleTextStyle,
                            decoration: InputDecoration(
                              hintText: 'taskname...',
                              border: InputBorder.none,
                              hintStyle: kAddNoteTitleTextStyle.copyWith(
                                  color: Colors.grey[400]),
                            ),
                            onChanged: (value) {
                              title = value;
                            },
                          ),
                        ),
                        Icon(
                          Icons.label,
                          color: Color(labelColor).withOpacity(1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 30,
                child: Consumer<Labels>(
                  builder: (context, labels, _) => ListView.builder(
                    itemCount: labels.labels.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) => GestureDetector(
                      onTap: () {
                        setState(() {
                          labelId = labels.labels[i].id;
                          labelColor = labels.labels[i].colorValue;
                        });
                        print(labelId);
                      },
                      child: Transform.rotate(
                        angle: 90 * pi / 180,
                        child: Icon(
                          Icons.label,
                          color:
                              Color(labels.labels[i].colorValue).withOpacity(1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  initialValue: content,
                  maxLines:
                      (MediaQuery.of(context).size.height * 0.014).toInt(),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      hintText: 'add details...',
                      hintStyle: kAddDetailNoteDetailTextStyle.copyWith(
                          color: Colors.grey[400])),
                  onChanged: (value) {
                    content = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
