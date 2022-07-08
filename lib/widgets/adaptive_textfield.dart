import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function dataHandler;
  final String label;
  final TextInputType inputType;

  const AdaptiveTextField(
      {Key key, this.controller, this.dataHandler, this.label, this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*Platform.isIOS ? CupertinoTextField(
      keyboardType: inputType,
      controller: controller,
      onSubmitted: dataHandler,
      placeholder: label,
    ) : */
        TextField(
      keyboardType: inputType,
      controller: controller,
      onSubmitted: dataHandler,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
