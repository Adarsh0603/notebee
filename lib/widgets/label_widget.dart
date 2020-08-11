import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/label.dart';

class LabelWidget extends StatelessWidget {
  final Label label;
  LabelWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            Icons.label,
            color: Color(label.colorValue).withOpacity(1),
          ),
          SizedBox(width: 10),
          Text(label.label),
        ],
      ),
    );
  }
}
