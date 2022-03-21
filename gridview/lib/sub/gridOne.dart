import 'package:flutter/material.dart';

class GridOne extends StatefulWidget {
  const GridOne({ Key? key }) : super(key: key);

  @override
  State<GridOne> createState() => _GridOneState();
}

class _GridOneState extends State<GridOne> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(30, (index){
          return new Card(
            elevation: 10.0,
            margin: EdgeInsets.all(10.0),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: new Container(
              child: Align(
                alignment: Alignment.center,
                child: new Text(
                  "$index",
                  style: TextStyle(
                    fontSize: 24.0
                  ),
                  ),
              ),
            ),
          );
        }),
        ),
    );
  }
}