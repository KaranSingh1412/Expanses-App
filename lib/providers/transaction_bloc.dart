import 'package:expanse_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionBloc extends ChangeNotifier {
  final List<Transaction> _userTransactions = [];

  void _deleteTransaction(String id) {
    _userTransactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}