import 'package:flutter/material.dart';
import 'package:flutter_database_sql/models/label.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:provider/provider.dart';

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
          Spacer(),
          FlatButton(
              onPressed: () async {
                await Provider.of<Labels>(context, listen: false)
                    .deleteLabel(label.id);
              },
              child: Text('REMOVE'))
        ],
      ),
    );
  }
}
