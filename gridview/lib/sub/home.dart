import 'package:flutter/material.dart';
import 'gridOne.dart' as gridone;
import 'gridTwo.dart' as gridtwo;
import 'form.dart' as gridthree;

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin{

  late TabController controller;
  
  @override
  void initState(){
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar:  new AppBar(
        title: new Text("Grid View"),
        backgroundColor: Colors.green,
        bottom: new TabBar(
          controller: controller,
          indicatorWeight: 5.0 ,
          //indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.pink,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.face),),
            new Tab(icon: new Icon(Icons.image),),
            new Tab(icon: new Icon(Icons.image),),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new gridone.GridOne(),
          new gridtwo.GridTwo(),
          new gridthree.Form(),
        ],
      ),
    );
  }
}