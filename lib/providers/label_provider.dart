import 'package:flutter/cupertino.dart';
import 'package:flutter_database_sql/models/label.dart';
import 'package:flutter_database_sql/providers/dbhelper.dart';

class Labels with ChangeNotifier {
  List<Label> _labelsList = [];

  List<Label> get labels {
    return [..._labelsList].reversed.toList();
  }

  Future<void> addLabel(String labelText, int colorValue) async {
    Label newLabel =
        Label(DateTime.now().toIso8601String(), labelText, colorValue);
    _labelsList.add(newLabel);
    await DBHelper.insert('labels', newLabel.toMap());
    await getLabels();
  }

  Future<void> deleteLabel(String labelId) async {
    _labelsList.removeWhere((element) => element.id == labelId);
    notifyListeners();
    await DBHelper.deleteDataFromDb('labels', labelId);
  }

  Future<void> getLabels() async {
    List<Map<String, dynamic>> labelsFromDatabase =
        await DBHelper.getDataFromTable('labels');
    _labelsList = labelsFromDatabase
        .map((label) => Label(label['id'], label['label'], label['color']))
        .toList();
    notifyListeners();
  }
}
