import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title;
  String content;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Notes>(context, listen: false).getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('NotesApp'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Title'),
            onChanged: (value) {
              title = value;
              print(title);
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Content'),
            onChanged: (value) {
              content = value;
            },
          ),
          FlatButton(
            onPressed: () async {
              await Provider.of<Notes>(context, listen: false)
                  .addNote(title, content);
            },
            child: Text('Save Note'),
          ),
          Expanded(
            child: FutureBuilder(
              future: notes.getNotes(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? ListView.builder(
                        itemCount: notes.notesList.length,
                        itemBuilder: (context, i) => Text(
                            '${notes.notesList[i].title} ${notes.notesList[i].content}'))
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
