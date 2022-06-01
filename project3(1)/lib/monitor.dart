import 'package:flutter/material.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';

class monitor extends StatefulWidget {
  const monitor({ Key? key }) : super(key: key);

  @override
  State<monitor> createState() => _monitorState();
}

class _monitorState extends State<monitor> {
  final ScrollController horizontalScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        primary: false,
        child: Container(
          child: Center(
            child: AdaptiveScrollbar(
              controller: horizontalScroll,
              position: ScrollbarPosition.bottom,
              scrollToClickDelta: 75,
              scrollToClickFirstDelay: 200,
              scrollToClickOtherDelay: 50,
              sliderDecoration: const BoxDecoration(
                  color: Color.fromARGB(255, 172, 186, 201),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              sliderActiveDecoration: const BoxDecoration(
                  color: Color.fromRGBO(206, 206, 206, 100),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              underColor: Colors.transparent,
              child: SingleChildScrollView(
                primary: false,
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Table(
                          defaultColumnWidth: FixedColumnWidth(200.0),
                          border: TableBorder.symmetric(
                          inside: BorderSide(width: 10, color: Colors.white),
                          outside: BorderSide(width: 2, color: Color.fromARGB(255, 47, 148, 179),)),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: const [
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromARGB(255, 47, 148, 179),),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'WINDOW 1', 
                                    textAlign: TextAlign.center, 
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white,
                                    )
                                  ),
                                ),
                                Text(
                                  'WINDOW 2', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                                ),
                                Text(
                                  'WINDOW 3', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                                ),
                                Text(
                                  'WINDOW 4', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                                ),
                                Text(
                                  'WINDOW 5', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                                ),
                                Text(
                                  'WINDOW 6', 
                                  textAlign: TextAlign.center, 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                                ),
                              ]
                            ),
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromARGB(255, 172, 186, 201),),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text('EDUC-0001', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                ),
                                Text('BSIT-0001', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('ENGR-0001', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('BSBA-0001', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('C', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                                Text('C', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                              ]
                            ),
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromARGB(255, 215, 228, 243),),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text('EDUC-0002', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                ),
                                Text('BSIT-0002', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('ENGR-0002', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('ACC-0002', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('L', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                                Text('L', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                              ]
                            ),
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromARGB(255, 172, 186, 201),),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text('EDUC-0003', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                ),
                                Text('BSIS-0003', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('ENGR-0003', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('BSBA-0003', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('O', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                                Text('O', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                              ]
                            ),
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromARGB(255, 215, 228, 243),),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text('EDUC-0002', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                ),
                                Text('BSIT-0004', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('ENGR-0004', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('BAIS-0004', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('S', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                                Text('S', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                              ]
                            ),
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromARGB(255, 172, 186, 201),),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text('EDUC-0003', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                ),
                                Text('BSIS-0004', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('ENGR-0004', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('BSBA-0004', textAlign: TextAlign.center, style: TextStyle(fontSize: 25,),),
                                Text('E', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                                Text('E', textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Color.fromARGB(255, 139, 35, 28)),),
                              ]
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Container(
                                width: 170,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 14, 111, 141),
                                  onPrimary: Colors.grey, 
                                  minimumSize: Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), 
                                  ),
                                  ),
                                  
                                  onPressed: () {
                                  },
                              
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Open Portal",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: 170,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 175, 56, 47),
                                  onPrimary: Colors.grey, 
                                  minimumSize: Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), 
                                  ),
                                  ),
                                  
                                  onPressed: () {
                                  },
                              
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Close Portal",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}