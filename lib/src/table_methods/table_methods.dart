import 'package:flutter/material.dart';

class TableRowRecord {
  final int id;
  bool isExpanded;

  TableRowRecord({ required this.id, required this.isExpanded });
}

/// Represents expanded or collapsed view of row
class ExpandingState extends Object with ChangeNotifier {
  final records = <int, bool>{};

  void updateExpandingView(int id, bool isExpanded) {
    records.update(id, (isExp) => !isExp, ifAbsent: () => isExpanded);
    notifyListeners();
  }

  bool isExpanded(int id) {
    bool result = records.putIfAbsent(id, () => false);

    return result;
  }

  void removeExpandingRecord(int id) {
    records.remove(id);
  }
}

/// Represents shown or hidden buttons (edit, delete) block on row
class ButtonsState extends ExpandingState {
  final editAndDeleteButtonsView = <int, bool>{};

  void updateEditAndDeleteButtonsView(int index, bool value) {
    editAndDeleteButtonsView.update(index, (value) => !value, ifAbsent: () => value);
    notifyListeners();
  }

  bool areEditAndDeleteButtonsShown(int index) {
    return editAndDeleteButtonsView.putIfAbsent(index, () => false);
  }
}

class TableMethods extends ButtonsState {}
