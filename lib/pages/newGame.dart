import 'package:flutter/foundation.dart';
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
    Colors.purple,
    Colors.amber,
    Colors.white,
  ];
  List codemaker = [Colors.red, Colors.blue, Colors.green, Colors.amber];
  List rows = [
    {
      "row": 10,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 9,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 8,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 7,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 6,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 5,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 4,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 3,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 2,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
    {
      "row": 1,
      "colors": [
        Colors.transparent,
        Colors.transparent,
        Colors.transparent,
        Colors.transparent
      ]
    },
  ];

  List selectedCircle = [];
  // double rowSelected = 0;

  // List circles

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // addItems() {}
  circles() {
    List<Widget> items = [];

    rows.asMap().forEach((ii, val) {
      items.add(Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  val["row"].toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [0, 1, 2, 3].map((i) {
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: circle(
                          selected: getSelected(val["row"], i),
                          color:
                              val["colors"].isEmpty ? null : val["colors"][i],
                          size: width * 0.1,
                          value: null,
                          onTap: () {
                            // getSelected(i);
                            setState(() {});
                            // print('\n\n\n asdasdlkjaskdaskd');
                            // print(val['pos']);
                            // print(val["colors"].isEmpty
                            //     ? "vacio"
                            //     : val["colors"][i]);
                            selectedCircle.clear();
                            selectedCircle.addAll([val["row"], i]);
                            // setState(() {
                            // });
                            // rows[index]["colors"][0]
                          }));
                }).toList(),
              )
            ],
          )));
    });
    return items;
  }

  getSelected(row, index) {
    print(selectedCircle);
    print(row);
    print(index);
    // return false;
    return selectedCircle.length == 0
        ? false
        : selectedCircle[0] == row && selectedCircle[1] == index;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print(rows);
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[table(), selectColors()],
              ),
            ),
            bottomActions()
          ],
        ));
  }

  Widget table() {
    return Container(child: Column(children: circles()));
  }

  Widget selectColors() {
    return Container(
      height: height * 0.6,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: masterColors.map((color) {
          return Card(
              // color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: circle(color: color, size: width * 0.1, value: 0),
              ));
        }).toList(),
      ),
    );
  }

  Widget bottomActions() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 40),
              width: width * 0.48,
              child: RaisedButton(
                onPressed: () {},
                // onPressed: checkLine(),
                child: Text("Check"),
              )),
          SizedBox(
            width: 40,
          ),
          InkWell(
              onTap: () => AppDialog(context: context),
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
