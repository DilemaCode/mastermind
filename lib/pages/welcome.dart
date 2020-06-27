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
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed('/CreateGame'),
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Create Game"),
                  width: 100,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed('/NewGame'),
                child: Container(
                  alignment: Alignment.center,
                  child: Text("New Game"),
                  width: 100,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed('/NewGame'),
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Invited Game"),
                  width: 100,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Text("How To Play"),
                  width: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
