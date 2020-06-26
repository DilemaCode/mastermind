import 'package:flutter/material.dart';

class AppDialog {
  // ignore: missing_return
  factory AppDialog({BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.warning, size: 60),
                            Text(
                              "Do you wannt use this hint?",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        )),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: 'What do you want to remember?'),
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                            elevation: 0,
                            color: Colors.transparent,
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Use",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                    // SizedBox(
                    //   width: 320.0,
                    //   child:
                    // )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
