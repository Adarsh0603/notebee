import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/searchWidgets/all_label.dart';
import 'package:flutter_database_sql/widgets/searchWidgets/labels_search_list.dart';
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
                  AllLabel(),
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
