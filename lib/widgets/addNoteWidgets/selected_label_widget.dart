import 'dart:math';

import 'package:flutter/material.dart';

class SelectedLabelWidget extends StatelessWidget {
  final int labelColor;

  SelectedLabelWidget({this.labelColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.rotate(
          angle: 180 * pi / 180,
          child: Icon(
            Icons.label,
            size: 20,
            color: Color(labelColor).withOpacity(1),
          ),
        ),
      ],
    );
  }
}
