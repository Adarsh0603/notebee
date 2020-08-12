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
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        children: [
          Icon(
            Icons.label,
            color: Color(label.colorValue).withOpacity(1),
          ),
          SizedBox(width: 10),
          Text(
            label.label.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Spacer(),
          IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                await Provider.of<Labels>(context, listen: false)
                    .deleteLabel(label.id);
              },
              icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
