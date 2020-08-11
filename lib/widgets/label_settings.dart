import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/widgets/label_widget.dart';
import 'package:provider/provider.dart';

class LabelSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddLabel(),
        ),
        Container(
          height: 300,
          child: FutureBuilder(
            future: Provider.of<Labels>(context, listen: false).getLabels(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<Labels>(
                      builder: (BuildContext context, labels, _) {
                        return ListView.builder(
                          itemBuilder: (ctx, i) =>
                              LabelWidget(labels.labels[i]),
                          itemCount: labels.labels.length,
                        );
                      },
                    );
            },
          ),
        )
      ],
    );
  }
}

class AddLabel extends StatelessWidget {
  final labelTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: labelTextController,
        decoration: InputDecoration(hintText: 'Add Label'),
        onSubmitted: (value) async {
          await Provider.of<Labels>(context, listen: false)
              .addLabel(value, (Random().nextDouble() * 0xFFFFFF).toInt());
          labelTextController.clear();
        });
  }
}
