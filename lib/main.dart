import 'package:flutter/material.dart';
import 'package:mastermind/pages/createGame.dart';
import 'package:mastermind/pages/newGame.dart';
import 'package:mastermind/pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: {
        "/": (context) => Welcome(),
        "/NewGame": (context) {
          Map arg = ModalRoute.of(context).settings.arguments;
          var invidationCode;
          if (arg != null) {
            invidationCode = arg["invidationCode"];
          }
          return NewGame(
            invidationCode: invidationCode,
          );
        },
        "/CreateGame": (context) => CreateGame(),
      },
    );
  }


}
