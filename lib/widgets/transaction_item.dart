import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.money,
    @required this.transaction,
    @required this.removeHandler,
  }) : super(key: key);

  final String money;
  final transaction;
  final Function removeHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    var rand = new Random();
    List<int> colorList = [];

    for (var i = 0; i < 3; i++) {
      var c = rand.nextInt(255);
      colorList.add(c);
      //print(c);
    }
    _bgColor = Color.fromRGBO(colorList[0], colorList[1], colorList[2], 100);
    print(colorList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text('${widget.money}${widget.transaction.amount}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                icon: Icon(Icons.delete),
                label: Text(
                  'Löschen',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
                //textColor: Theme.of(context).errorColor,
                onPressed: () => widget.removeHandler(widget.transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.removeHandler(widget.transaction.id),
              ),
      ),
    );
  }
}
