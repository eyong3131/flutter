import 'package:flutter/material.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.deepPurple,
//        width: 200.0,
//        height: 100.0,
//        margin: EdgeInsets.only(left: 15.0, top: 50.0 ),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
            Expanded(child: Text(
              'Hello',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 35.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
    //          fontStyle: FontStyle.italic,
                color:  Colors.white,
                ),
              )),
            Expanded(child:Text(
              'To The very handsome guy Leo and the ', 
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
    //          fontStyle: FontStyle.italic,
                color:  Colors.white,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
            Expanded(child: Text(
              'Hello',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 35.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
    //          fontStyle: FontStyle.italic,
                color:  Colors.white,
                ),
              )),
            Expanded(child:Text(
              'To The very handsome guy Leo and the ', 
              textDirection: TextDirection.ltr,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20.0,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700,
    //          fontStyle: FontStyle.italic,
                color:  Colors.white,
                ),
              )),
            ],
          )
        ],)
        

      )
    );
    

  }
}