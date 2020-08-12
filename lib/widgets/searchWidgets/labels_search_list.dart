import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:provider/provider.dart';

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
                color: Color(labels.labels[i].colorValue).withOpacity(1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
