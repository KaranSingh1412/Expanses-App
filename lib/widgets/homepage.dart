import 'dart:io';

import 'package:expanse_app/models/transaction.dart';
import 'package:expanse_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart.dart';
import 'new_transactions.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _userTransactions = [];
  String dropdownValue = '€';
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((t) {
      return t.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String tTitle, double tAmount, DateTime chosenDate) {
    final newT = Transaction(
      title: tTitle,
      amount: tAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newT);
    });
  }

  void _showTransactionAddMenu(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NewTransaction(
          addT: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((t) => t.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, AppBar appBar, Widget tListWidget) {
    return [
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Chart', style: Theme.of(context).textTheme.title,),
        Switch.adaptive(
          value: _showChart,
          activeColor: Theme.of(context).accentColor,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    ),
      _showChart
          ? Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
        child: Chart(
          money: dropdownValue,
          recentTransactions: _recentTransactions,
        ),
      )
          : tListWidget
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar, Widget tListWidget) {
    return [
      Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
      child: Chart(
        money: dropdownValue,
        recentTransactions: _recentTransactions,
      ),
    ),
      tListWidget];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 50,
            child: DropdownButton(
              value: dropdownValue,
              icon: Icon(CupertinoIcons.down_arrow),
              elevation: 5,
              items: <String>['\$', '€', '₤'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
            ),
          ),
          GestureDetector(
            child: Icon(
              CupertinoIcons.add,
            ),
            onTap: () => _showTransactionAddMenu(context),
          ),
        ],
      ),
    )
        : AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        Container(
          width: 50,
          child: DropdownButton(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            elevation: 5,
            items: <String>['\$', '€', '₤'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showTransactionAddMenu(context),
        ),
      ],
    );

    final tListWidget =
    Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.7,
      child: TransactionList(
        money: dropdownValue,
        transactions: _userTransactions,
        removeHandler: _deleteTransaction,
      ),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) ..._buildLandscapeContent(mediaQuery, appBar, tListWidget),
            if(!isLandscape) ..._buildPortraitContent(mediaQuery, appBar, tListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    ) : Scaffold(
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showTransactionAddMenu(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: appBar,
      body: pageBody,
    );
  }
}
