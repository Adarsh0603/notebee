import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:provider/provider.dart';

class LabelSettings extends StatefulWidget {
  @override
  _LabelSettingsState createState() => _LabelSettingsState();
}

class _LabelSettingsState extends State<LabelSettings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Labels>(builder: (buildContext, labels, _) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Add Label'),
              onSubmitted: (value) async {
                await labels.addLabel(
                    value, (Random().nextDouble() * 0xFFFFFF).toInt());
              },
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
              itemBuilder: (ctx, i) => Text(labels.labels[i].label),
              itemCount: labels.labels.length,
            ),
          )
        ],
      );
    });
  }
}
