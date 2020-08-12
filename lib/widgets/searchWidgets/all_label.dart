import 'dart:math';

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
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Transform.rotate(
          angle: 90 * pi / 180,
          child: Icon(
            Icons.label_outline,
            size: 20,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
