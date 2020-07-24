import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/utils/circle.dart';
import 'package:mastermind/utils/colors.dart';
import 'package:mastermind/utils/dialog.dart';

import '../services/rest.dart';
import '../utils/dialog.dart';

class NewGame extends StatefulWidget {
  String invidationCode;
  NewGame({this.invidationCode});
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  double width;
  double height;

  List codemaker = [];
  // List codemaker = [Colors.red, Colors.blue, Colors.green, Colors.brown];
  List<List<Map<String, dynamic>>> rows = [];

  List selectedCircle = [0, 0];
  int rowSelected = 0;

  bool hintUsed = false;
  Random random = new Random();

  // double rowSelected = 0;

  // List circles

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < 10; i++) {
      rows.add([
        {
          "color": Colors.transparent,
          "name": "empty",
          "value": null,
        },
        {
          "color": Colors.transparent,
          "name": "empty",
          "value": null,
        },
        {
          "color": Colors.transparent,
          "name": "empty",
          "value": null,
        },
        {
          "color": Colors.transparent,
          "name": "empty",
          "value": null,
        }
      ]);
    }

    if (widget.invidationCode == null) {
      codemaker.addAll(AppColors.masterColors);
      codemaker.shuffle();
      codemaker.removeRange(3, 7);
      print(codemaker);
    } else {
      FS.getGameById(widget.invidationCode).then((data) {
        if (data["id"] == "error") {
          //modal s

          // AppDialog()
        } else {
          codemaker = data["codemaker"];
          setState(() {});
        }
      });
    }

    super.initState();
  }

  getSelected(row, index) {
    return selectedCircle.length == 0
        ? false
        : selectedCircle[0] == row && selectedCircle[1] == index;
  }

  getNext() {
    print('\n\n\n NEXT ITEM');
    var index = rows[rowSelected].indexWhere((item) => item["name"] == "empty");
    selectCircle(index == -1 ? null : index);
  }

  selectCircle(i) {
    selectedCircle.clear();
    selectedCircle.addAll([rowSelected, i]);
  }

  setCircleValue(value) {
    rows[selectedCircle[0]][selectedCircle[1]] = value;
  }

  bool codemakerContains(var name) {
    for (var e in codemaker) {
      if (e["name"] == name) return true;
    }
    return false;
  }

  checkRow(BuildContext context) async {
    var row = rows[rowSelected];

    codemaker.asMap().forEach((i, value) {
      var value = codemaker[i];
      if (codemakerContains(row[i]["name"])) {
        rows[rowSelected][i]["value"] = 2;
      }

      if (value["name"] == row[i]['name']) {
        rows[rowSelected][i]["value"] = 1;
      }
    });
    setState(() {});
    if (rows[rowSelected].where((e) => e['name'] == "empty").isNotEmpty)
      AlertDialog();
    else if (rowSelected == 9) {
      // lose
      AppDialog(
          context: context,
          title: "You Lose!",
          buttonLabel: "ok",
          onCancel: () {
            Navigator.pop(context);
          },
          onAccept: () {
            Navigator.pop(context);
          });
    } else if (rows[rowSelected].where((e) => e['value'] == 1).length == 4) {
      AppDialog(
          context: context,
          title: "You win!",
          buttonLabel: "ok",
          cancelText: "Share",
          onCancel: () {
            Navigator.pop(context);
          },
          onAccept: () {
            Navigator.pop(context);
          });
    } else
      rowSelected = rowSelected + 1;
    selectCircle(0);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print("\n\n\n\ncodemaker");
    print(codemaker);
    return Scaffold(
        appBar: AppBar(
          title: Text("Master Mind"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                AppDialog(
                    context: context,
                    title: "Colors",
                    buttonLabel: "ok",
                    height: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: codemaker.map((item) {
                        return Padding(
                            padding: EdgeInsets.all(5),
                            child: circle(
                                color: item["color"],
                                size: width * 0.08,
                                value: 0,
                                onTap: () {}));
                      }).toList(),
                    ),
                    onCancel: () {
                      // Navigator.pop(context);
                    },
                    onAccept: () {
                      // Navigator.pop(context);
                    });
              },
              icon: Icon(Icons.ac_unit),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[table(), selectColors()],
              ),
            )),
            bottomActions(context)
          ],
        ));
  }

  Widget table() {
    return Expanded(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: rows.length,
            reverse: true,
            dragStartBehavior: DragStartBehavior.down,
            shrinkWrap: true,
            itemBuilder: (context, row) {
              var val = rows[row];
              return Container(
                // width: width / 1.8,
                height: width * 0.1,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      child: Text(
                        (row + 1).toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                        color: rowSelected == row ? Colors.white10 : null,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, i) {
                            return Container(
                                padding: EdgeInsets.symmetric(horizontal: 7),
                                // margin: EdgeInsets.only(bottom: 5),
                                child: circle(
                                    selected: getSelected(row, i),
                                    color: val[i]["color"],
                                    // val["colors"].isEmpty
                                    //     ? null
                                    //     : val["colors"][i]["color"],
                                    size: width * 0.1-16,
                                    value: val[i]["value"],
                                    onTap: row == rowSelected
                                        ? () {
                                            setState(() {});
                                            selectCircle(i);
                                          }
                                        : null));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                ),
              );
            }));
  }

  Widget selectColors() {
    return Container(
      height: height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: AppColors.masterColors.map((item) {
          return Card(
              child: Padding(
            padding: EdgeInsets.all(5),
            child: circle(
              color: rows[rowSelected]
                      .where((elem) => item["name"] == elem["name"])
                      .isNotEmpty
                  ? item["color"].withOpacity(0.2)
                  : item["color"],
              size: width * 0.1,
              value: 0,
              onTap: rows[rowSelected]
                      .where((elem) => item["name"] == elem["name"])
                      .isNotEmpty
                  ? null
                  : selectedCircle[1] == null
                      ? null
                      : () {
                          setCircleValue({
                            "value": 0,
                            "color": item["color"],
                            "name": item["name"]
                          });
                          getNext();
                          setState(() {});
                        },
            ),
          ));
        }).toList(),
      ),
    );
  }

  Widget bottomActions(context) {
    return Container(
      padding: EdgeInsets.only(bottom: height * 0.05, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: width * 0.48,
              child: RaisedButton(
                onPressed: () => checkRow(context),
                child: Text("Check"),
              )),
          InkWell(
              onTap: () => AppDialog(
                  context: context,
                  title: hintUsed
                      ? "Hint already used"
                      : "Do you wannt use this hint?",
                  buttonLabel: hintUsed ? "Ok" : "Use Hint",
                  onAccept: hintUsed
                      ? null
                      : () {
                          var _r = Random().nextInt(codemaker.length);
                          for (var i = 0; i < rows.length; i++) {
                            rows[i][_r] = {"value": 0, ...codemaker[_r]};
                          }
                          // rows.asMap().forEach((key, value) {
                          // });
                          hintUsed = true;
                          setState(() {});
                        }),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.lightbulb_outline),
                      Text("Hint"),
                    ],
                  ))),
        ],
      ),
    );
  }
}
