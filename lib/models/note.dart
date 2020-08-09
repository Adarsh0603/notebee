class Note {
  final String id;
  final String title;
  final String content;

  Note({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
