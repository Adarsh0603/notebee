import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/providers/notes_provider.dart';
import 'package:flutter_database_sql/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(QuickNote());
}

class QuickNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Notes()),
        ChangeNotifierProvider(create: (BuildContext context) => Labels()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        title: 'QuickNote',
      ),
    );
  }
}
