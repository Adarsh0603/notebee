import 'package:flutter/material.dart';
import 'package:flutter_database_sql/constants.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String content;
  Future<bool> saveNote() {
    Navigator.of(context).pop({'title': title, 'content': content});
  }

  @override
  Widget build(BuildContext context) {
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
                    child: TextField(
                      style: kAddNoteTitleTextStyle,
                      decoration: InputDecoration(
                        hintText: 'taskname...',
                        border: InputBorder.none,
                        hintStyle: kAddNoteTitleTextStyle.copyWith(
                            color: Colors.grey[400]),
                      ),
                      onChanged: (value) {
                        title = value;
                        print(title);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  maxLines:
                      (MediaQuery.of(context).size.height * 0.017).toInt(),
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
////                await notes.addNote(title, content);
            ],
          ),
        ),
      ),
    );
  }
}
