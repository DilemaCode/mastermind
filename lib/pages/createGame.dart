import 'package:flutter/material.dart';
import 'package:mastermind/utils/circle.dart';
import 'package:share/share.dart';

class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
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
  List codemaker = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ];
  int selectedCircle = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getNext() {
    print('\n\n\n NEXT ITEM');
    var index = codemaker.indexWhere((item) => item == Colors.transparent);
    print(index);

    selectedCircle = index == -1 ? null : index;
  }

  getSelected(index) {
    return selectedCircle == index;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Game"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            width: width / 1.8,
            alignment: Alignment.center,
            height: width * 0.1,
            child: colorsRow(),
          ),
          selectColors(),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 10, top: 100),
            child: RaisedButton(
              onPressed: () {
                  Share.share(
                      'Hello, I invite you to guess the colors in MasterMind:\n app://mastermind.game/game=123');
                // if (codemaker.where((e) => e == Colors.transparent).isEmpty)
              },
              child: Container(
                alignment: Alignment.center,
                child: Text("Share"),
                width: 100,
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget colorsRow() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: codemaker.length,
        itemBuilder: (context, i) {
          var val = codemaker[i];
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: circle(
                  selected: getSelected(i),
                  color: val,
                  size: width * 0.1,
                  value: val == Colors.transparent ? null : 0,
                  onTap: () {
                    selectedCircle = i;
                    setState(() {});
                  }));
        });
  }

  Widget selectColors() {
    return Container(
      alignment: Alignment.center,
      width: width / 1.5,
      height: height * 0.2,
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: masterColors.map((color) {
          return Card(
              child: Padding(
            padding: EdgeInsets.all(5),
            child: circle(
              color: color,
              size: width * 0.1,
              value: 0,
              onTap: selectedCircle == null
                  ? null
                  : () {
                      print("object");
                      codemaker[selectedCircle] = color;
                      getNext();
                      setState(() {});
                    },
            ),
          ));
        }).toList(),
      ),
    );
  }
}
