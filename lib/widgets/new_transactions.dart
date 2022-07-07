import 'package:expanse_app/widgets/adaptive_flat_button.dart';
import 'package:expanse_app/widgets/adaptive_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addT;

  NewTransaction({this.addT});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addT(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );
    Navigator.pop(context);
  }

  // ignore: non_constant_identifier_names
  void _DatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AdaptiveTextField(
                controller: _titleController,
                dataHandler: (_) => _submitData,
                label: 'Titel',
              ),
              AdaptiveTextField(
                controller: _amountController,
                dataHandler: (_) => _submitData,
                label: 'Amount',
                inputType: TextInputType.numberWithOptions(decimal: true),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'Kein Datum ausgewählt'
                            : 'Gewähltes Datum: ${DateFormat.yMd().format(_selectedDate)}')),
                    AdaptiveFlatButton(
                      text: 'Choose Date',
                      handler: _DatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color),
                ),
                //color: Theme.of(context).primaryColor,
                //textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
