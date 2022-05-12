import 'package:flutter/material.dart';

class GridTwo extends StatefulWidget {
  const GridTwo({ Key? key }) : super(key: key);

  @override
  State<GridTwo> createState() => _GridTwoState();
}

class _GridTwoState extends State<GridTwo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                children: <Widget>[
                  new Image.network(
                    "https://www.maxpixel.net/static/photo/1x/Hd-Wallpaper-Water-Lily-Flower-Aquatic-Plant-3784022.jpg",
                    height: 130.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                  new SizedBox(height: 5.0,),
                  new Text(
                    "\$50",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    ),
                    ),
                ],
              ),
            ),
          )
        ],
        ),
    );
  }
}