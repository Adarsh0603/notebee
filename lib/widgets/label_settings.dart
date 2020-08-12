import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_database_sql/providers/label_provider.dart';
import 'package:flutter_database_sql/widgets/label_widget.dart';
import 'package:provider/provider.dart';

class LabelSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Manage Labels',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Divider(),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
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
        ),
        Divider(),
        AddLabel(),
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
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: 'ADD LABEL',
            hintStyle: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
            border: InputBorder.none),
        onSubmitted: (value) async {
          await Provider.of<Labels>(context, listen: false)
              .addLabel(value, (Random().nextDouble() * 0xFFFFFF).toInt());
          labelTextController.clear();
        });
  }
}
