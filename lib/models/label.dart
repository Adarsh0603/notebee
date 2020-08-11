import 'dart:ui';

class Label {
  final String id;
  final String label;
  final int colorValue;

  Label(this.id, this.label, this.colorValue);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'color': colorValue,
    };
  }
}
