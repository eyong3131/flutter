import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unused_element
  _screenWidth() {
    double? myWidth;
    myWidth = MediaQuery.of(context).size.width * 0.25;
    return myWidth;
    //MediaQuery.of(context).size.width < 650 ? 150 : 250
  }

  // ignore: unused_element
  _screenHeight() {
    double? myHeight;
    myHeight = MediaQuery.of(context).size.height * 0.25;
    return myHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Waiting Area",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.10),
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
      ),
      body: _Content(),
    );
  }

  Widget _Content() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Row 1
          Row(),
        ],
      );

/* should be called in body

  Widget _columnControl() => Column(
          mainAxisAlignment: MediaQuery.of(context).size.width > 600
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Row 1
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                width: _screenWidth(),
                height: _screenHeight(),
                color: Colors.black,
              )),
              Expanded(
                  child: Container(
                width: _screenWidth(),
                height: _screenHeight(),
                color: Colors.redAccent,
              ))
            ]),
            //Conditional Row
            MediaQuery.of(context).size.width > 600
                ? Row(children: <Widget>[
                    Expanded(
                        child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.pinkAccent,
                    )),
                    Expanded(
                        child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.purpleAccent,
                    )),
                  ])
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.pinkAccent,
                  ),
            // Row 2
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                width: _screenWidth(),
                height: _screenHeight(),
                color: Colors.redAccent,
              )),
              Expanded(
                  child: Container(
                width: _screenWidth(),
                height: _screenHeight(),
                color: Colors.black,
              )),
            ]),
          ]);
          */
}
