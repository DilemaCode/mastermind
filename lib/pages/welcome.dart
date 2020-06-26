import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () =>Navigator.of(context).pushNamed('/NewGame'),
              child: Text("Star Game"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Create Game"),
            ),
          ],
        ),
      ),
    );
  }
}
