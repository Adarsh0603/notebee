import 'package:flutter/cupertino.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final String labelId;

  Note(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.labelId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'labelId': labelId,
    };
  }
}
