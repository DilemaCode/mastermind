import 'package:flutter/material.dart';
import 'package:mastermind/pages/newGame.dart';
import 'package:mastermind/pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: {
        "/": (context) => Welcome(),
        "/NewGame": (context) => NewGame(),
      },
    );
  }
}
