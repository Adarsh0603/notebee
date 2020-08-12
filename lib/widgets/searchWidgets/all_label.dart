import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class AllLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<Notes>(context, listen: false)
            .getAndSetSearchedNotesListWithLabel('all');
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'ALL',
            style: TextStyle(
                fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
          )),
    );
  }
}
