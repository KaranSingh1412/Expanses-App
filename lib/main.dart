import 'package:expanse_app/widgets/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

/*
*
* Todo:
*  - saving Data //Shared Preferences
*  - code structure // using Flutter Provider - BLOC Pattern
*  - init methods on top of the Widget
*  - instead of using Widget build methods, creating new Stateless Widgets
*
* */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /*textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
            ),*/
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        /*appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),*/
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
