import 'package:expanse_app/models/transaction.dart';
import 'package:expanse_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeHandler;
  final String money;

  TransactionList({this.transactions, this.removeHandler, this.money});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.snooze,
              color: Colors.black.withOpacity(0.1),
              size: 80,
            ),
            Text('Noch keine Einträge!', style: TextStyle(color: Colors.black.withOpacity(0.1)),)
          ],
        ),
      )
          :
    ListView(
      children: transactions.map((t) => TransactionItem(
        key: ValueKey(t.id),
        money: money,
        removeHandler: removeHandler,
        transaction: t,
      )).toList(),
    );
  }
}
