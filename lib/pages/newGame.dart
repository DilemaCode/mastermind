import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/utils/circle.dart';
import 'package:mastermind/utils/dialog.dart';

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  double width;
  double height;
  List masterColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.brown,
    Colors.cyan[200],
    Colors.orange,
  ];
  List codemaker = [Colors.red, Colors.blue, Colors.green, Colors.brown];
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
          "value": null,
        },
        {
          "color": Colors.transparent,
          "value": null,
        },
        {
          "color": Colors.transparent,
          "value": null,
        },
        {
          "color": Colors.transparent,
          "value": null,
        }
      ]);
    }
    super.initState();
  }

  // addItems() {}
  // circles() {
  //   List<Widget> items = [];

  //   rows.asMap().forEach((ii, val) {
  //     // items.add();
  //   });
  //   return items;
  // }

  getSelected(row, index) {
    return selectedCircle.length == 0
        ? false
        : selectedCircle[0] == row && selectedCircle[1] == index;
  }

  getNext() {
    print('\n\n\n NEXT ITEM');
    var index = rows[rowSelected]
        .indexWhere((item) => item["color"] == Colors.transparent);
    selectCircle(index == -1 ? null : index);
  }

  selectCircle(i) {
    selectedCircle.clear();
    selectedCircle.addAll([rowSelected, i]);
  }

  setCircleValue(value) {
    rows[selectedCircle[0]][selectedCircle[1]] = value;
  }

  checkRow(BuildContext context) {
    print("\n\n\n CHECKING");
    // print(rows[rowSelected]);
    // print(masterColors);
    var row = rows[rowSelected];
    // var _circles = [];
    codemaker.asMap().forEach((key, value) {
      if (value == row[key]['color']) {
        rows[rowSelected][key]["value"] = 1;
        // _circles.add({"value": 1, "color": row[key]});
        print("\n\n CORRECT");
      } else if (row.where((elm) => elm["color"] == value).isNotEmpty) {
        rows[rowSelected][key]["value"] = 2;

        print("\n\n inline");
      }
    });
    setState(() {});
    if (rows[rowSelected]
        .where((e) => e['color'] == Colors.transparent)
        .isNotEmpty)
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Master Mind"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
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
              // for (var i = 0; i < 4; i++) {
              //   rows[index]["colors"].add({
              //     "color": Colors.transparent,
              //     "value": null,
              //   });
              // }
              var val = rows[row];
              return Container(
                width: width / 2,
                height: width * 0.1,
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        (row + 1).toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, i) {
                              return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7),
                                  child: circle(
                                      selected: getSelected(row, i),
                                      color: val[i]["color"],
                                      // val["colors"].isEmpty
                                      //     ? null
                                      //     : val["colors"][i]["color"],
                                      size: width * 0.1,
                                      value: val[i]["value"],
                                      onTap: row == rowSelected
                                          ? () {
                                              setState(() {});
                                              selectCircle(i);
                                            }
                                          : null));
                            })),
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
        children: masterColors.map((color) {
          return Card(
              child: Padding(
            padding: EdgeInsets.all(5),
            child: circle(
              color: color,
              size: width * 0.1,
              value: 0,
              onTap: selectedCircle[1] == null
                  ? null
                  : () {
                      setCircleValue({"color": color, "value": 0});
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
                          rows.asMap().forEach((key, value) {
                            value[_r] = {"color": codemaker[_r], "value": 0};
                          });
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
