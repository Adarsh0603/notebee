import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/constants.dart';
import 'package:flutter_database_sql/models/note.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/widgets/addNoteWidgets/selected_label_widget.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  final Note note;
  AddNote({this.note});

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  FocusNode contentFocusNode = FocusNode();

  String title;
  String content;
  String labelId = 'default';
  int labelColor = 0x000000;
  bool labelNotChanged = true;
  Future<bool> saveNote() async {
    Navigator.of(context)
        .pop({'title': title, 'content': content, 'labelId': labelId});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      title = widget.note.title;
      content = widget.note.content;
      if (labelNotChanged) labelId = widget.note.labelId;
      if (labelNotChanged) {
        labelColor = Provider.of<Labels>(context, listen: false)
            .findLabelById(labelId)
            .colorValue;
      }
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
                      Navigator.pop(context, {
                        'title': title,
                        'content': content,
                        'labelId': labelId
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: title,
                            textInputAction: TextInputAction.next,
                            autofocus: widget.note != null ? false : true,
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
                            onFieldSubmitted: (_) {
                              contentFocusNode.requestFocus();
                            },
                          ),
                        ),
                        SelectedLabelWidget(labelColor: labelColor),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border:
                              Border.all(width: 1, color: Colors.grey[200])),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Consumer<Labels>(
                        builder: (context, labels, _) => ListView.builder(
                          itemCount: labels.labels.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              setState(() {
                                labelId = labels.labels[i].id;
                                labelColor = labels.labels[i].colorValue;
                                labelNotChanged = false;
                              });
                            },
                            child: Transform.rotate(
                              angle: 90 * pi / 180,
                              child: Icon(
                                Icons.label,
                                color: Color(labels.labels[i].colorValue)
                                    .withOpacity(1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: TextFormField(
                  focusNode: contentFocusNode,
                  textInputAction: TextInputAction.done,
                  initialValue: content,
                  onFieldSubmitted: (_) {
                    Navigator.of(context).pop({
                      'title': title,
                      'content': content,
                      'labelId': labelId
                    });
                  },
                  maxLines:
                      (MediaQuery.of(context).size.height * 0.013).toInt(),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
