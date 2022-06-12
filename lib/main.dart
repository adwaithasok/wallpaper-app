// @dart=2.9
// import 'package:setstate/main.dart';

import 'package:flutter/material.dart';

import 'package:setstate/view/home.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'walpaper',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
        ),
        home: const Home());
  }
}
