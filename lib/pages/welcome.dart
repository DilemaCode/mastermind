import 'dart:io' show Platform;

import 'package:flutter/services.dart';
// import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/utils/dialog.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // This widget is the root of your application.
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No data";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    print("\n\n\ndataShared:");
    print(dataShared);

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        // children: Wrap(
        // spacing: 20,
        // runSpacing: 20,
        // alignment: WrapAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.cover,
                      height: 78,
                    ),
                    Text(
                      "Master Mind",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    // Text(
                    //   "MIND",
                    //   style: TextStyle(
                    //       letterSpacing: 2,
                    //       fontSize: 16,
                    //       color: Colors.black),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          //   child:
          // ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: RaisedButton(
              elevation: 10,
              color: Color(0xffcb4c3b),
              onPressed: () => Navigator.of(context).pushNamed('/NewGame'),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "New Game",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: 80),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: RaisedButton(
              elevation: 10,
              color: Color(0xff6080f5),
              onPressed: () => Navigator.of(context).pushNamed('/CreateGame'),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Create Game",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: 80),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: RaisedButton(
              color: Color(0xff69a951),
              elevation: 10,
              onPressed: () => Navigator.of(context).pushNamed('/NewGame'),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "My Games",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: 80),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: RaisedButton(
              elevation: 10,
              color: Color(0xffeabf07),
              onPressed: () {
                AppDialog(
                    context: context,
                    title: dataShared.toString(),
                    buttonLabel: "ok",
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onAccept: () {
                      Navigator.pop(context);
                    });
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "How To Play",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: 80),
            ),
          ),
        ],
      ),
      // ),
    );
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }
}
