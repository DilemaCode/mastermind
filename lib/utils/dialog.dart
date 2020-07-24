import 'package:flutter/material.dart';

class AppDialog {
  // ignore: missing_return
  factory AppDialog(
      {BuildContext context,
      Function onCancel,
      Function onAccept,
      Widget child,
      double height,
      String cancelText,
      String title,
      String buttonLabel}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: height == null ? 180 : height,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.warning, size: 60),
                            Text(
                              title == null ? "Alert" : title,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        )),
                    Container(
                      child: child,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: buttonLabel == null
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              if (onCancel != null) {
                                onCancel();
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              cancelText == null ? "Cancel" : cancelText,
                              style: TextStyle(color: Colors.white),
                            ),
                            elevation: 0,
                            color: Colors.transparent,
                          ),
                          Container(
                            child: onAccept == null
                                ? null
                                : RaisedButton(
                                    onPressed: () {
                                      onAccept();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      buttonLabel == null
                                          ? "Accept"
                                          : buttonLabel,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                          )
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
