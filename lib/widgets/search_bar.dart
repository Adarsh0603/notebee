import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
//          textAlign: TextAlign.center,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey[300]),
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
                onChanged: (value) {
                  Provider.of<Notes>(context, listen: false)
                      .getAndSetSearchedNotesList(value);
                },
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[300]),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<Notes>(context, listen: false)
                          .getAndSetSearchedNotesListWithLabel('all');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Transform.rotate(
                        angle: 90 * pi / 180,
                        child: Icon(
                          Icons.label,
                          size: 20,
                          color: Color(0x000000).withOpacity(1),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LabelSearchList(),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class LabelSearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Labels>(
      builder: (context, labels, _) => ListView.builder(
        itemCount: labels.labels.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () {
            Provider.of<Notes>(context, listen: false)
                .getAndSetSearchedNotesListWithLabel(labels.labels[i].id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Transform.rotate(
              angle: 90 * pi / 180,
              child: Icon(
                Icons.label,
                size: 20,
                color: Color(labels.labels[i].colorValue).withOpacity(1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
