import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/widgets/app_title.dart';
import 'package:flutter_database_sql/widgets/label_settings.dart';
import 'package:flutter_database_sql/widgets/note_insert_widget.dart';
import 'package:flutter_database_sql/widgets/notes_display.dart';
import 'package:flutter_database_sql/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Labels>(context, listen: false).getLabels();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          var dataMap = await showDialog<Map<String, dynamic>>(
              barrierColor: Colors.white70,
              context: context,
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    children: [AddNote()],
                  ),
                );
              });
          if (dataMap['title'] != null && dataMap['content'] != null) {
            await Provider.of<Notes>(context, listen: false).addNote(
                dataMap['title'], dataMap['content'], dataMap['labelId']);
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTitle(),
              IconButton(
                icon: Icon(Icons.label),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        SimpleDialog(children: [LabelSettings()]),
                  );
                },
              )
            ],
          ),
          SearchBar(),
          Expanded(child: NotesDisplay()),
        ],
      )),
    );
  }
}
