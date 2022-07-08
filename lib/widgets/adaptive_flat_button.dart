import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  const AdaptiveFlatButton({Key key, this.text, this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : */
        TextButton(
      onPressed: handler,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
