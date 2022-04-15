import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiting Area"),
        centerTitle: true,
      ),
      body: _columnControl(),
    );
  }

  Widget _columnControl() => Column(
          mainAxisAlignment: MediaQuery.of(context).size.width > 600
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Row 1
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                width: 250,
                height: 250,
                color: Colors.black,
              )),
              Expanded(
                  child: Container(
                width: 250,
                height: 250,
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
                width: 250,
                height: 250,
                color: Colors.redAccent,
              )),
              Expanded(
                  child: Container(
                width: 250,
                height: 250,
                color: Colors.black,
              )),
            ]),
          ]);
}
