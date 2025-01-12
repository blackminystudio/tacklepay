import 'package:flutter/material.dart';
import '../../auth/store/models/user_model.dart';
import '../../transaction/store/models/transaction_model.dart';
import 'services/home_service.dart';

class HomeStore extends ChangeNotifier {
  HomeStore() {
    _findTodaysTransactions();
    _getTransactionSummary();
  }

  List<TransactionModel> _transactionlist = [];
  List<TransactionModel> get transactionList => _transactionlist;

  SummaryModel? _summaryModel;

  Future<void> _findTodaysTransactions() async {
    final data = await HomeService.getTodaytransactionList();
    _transactionlist = data.map(TransactionModel.fromJson).toList();
    notifyListeners();
  }

  Future<void> _getTransactionSummary() async {
    final data = await HomeService.getSummary();
    _summaryModel = SummaryModel.fromJson(data);
    notifyListeners();
  }

  String get getThisMonthIncome =>
      _summaryModel?.thisMonthIncome.toString() ?? '';

  String getPreviousIncomePercentage() {
    if (_summaryModel == null) return '0';
    final currentValue = _summaryModel?.thisMonthIncome ?? 0;
    final prevValue = _summaryModel?.prevMonthIncome ?? 0;
    if (prevValue == 0) {
      return (currentValue > 0 ? 100 : 0).toString();
    }
    return (((currentValue - prevValue) / prevValue) * 100).toInt().toString();
  }

  String get getThisMonthExpense =>
      _summaryModel?.thisMonthExpense.toString() ?? '';

  String getPreviousExpensePercentage() {
    if (_summaryModel == null) return '0';
    final currentValue = _summaryModel?.thisMonthExpense ?? 0;
    final prevValue = _summaryModel?.prevMonthExpense ?? 0;
    if (prevValue == 0) {
      return (currentValue > 0 ? 100 : 0).toString();
    }
    return (((currentValue - prevValue) / prevValue) * 100).toInt().toString();
  }
}
