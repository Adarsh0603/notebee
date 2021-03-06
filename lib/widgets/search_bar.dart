import 'package:flutter/material.dart';
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
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                    hintText: 'search notes',
                    hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
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
                onSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
