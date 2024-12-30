import 'package:flutter/material.dart';

class TransactionStore extends ChangeNotifier {
  bool isExpense = true;
  String amount = '';
  String message = '';
  List<String> tagList = [];
  DateTime dateTime = DateTime.now();

  void setAmount(String value) {
    amount = value;
    notifyListeners();
  }

  void setMessage(String value) {
    message = value;
    notifyListeners();
  }

  void addTag(String value) {
    tagList.add(value);
    notifyListeners();
  }

  void setIsExpense(bool value) {
    isExpense = value;
    notifyListeners();
  }

  void setDate(String value) {
    dateTime = DateTime.parse(value);
    notifyListeners();
  }
}
