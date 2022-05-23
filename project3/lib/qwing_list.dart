import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class qwingList extends StatefulWidget {
  const qwingList({ Key? key }) : super(key: key);

  @override
  State<qwingList> createState() => _qwingListState();
}

class _qwingListState extends State<qwingList> {

  List<String> cancelledw1 = ["EDUC-0021","EDUC-0022","EDUC-0023","EDUC-0024","EDUC-0025","EDUC-0026","EDUC-0027",
  "EDUC-0028","EDUC-0029","EDUC-0030"];
  List<String> qw1 = ["EDUC-0011","EDUC-0012","EDUC-0013","EDUC-0014","EDUC-0015","EDUC-0016","EDUC-0017",
  "EDUC-0018","EDUC-0019","EDUC-0020"];
  List<String> donew1 = ["EDUC-001","EDUC-002","EDUC-003","EDUC-004","EDUC-005","EDUC-006","EDUC-007",//window1
     "EDUC-008","EDUC-009","EDUC-010"];

  List<String> cancelledw2 = ["BSIT-0021","BSIT-0022","BSIT-0023","BSIT-0024","BSIT-0025","BSIT-0026","BSIT-0027",
  "BSIT-0028","BSIT-0029","BSIT-0030"];
  List<String> qw2 = ["BSIT-0011","BSIT-0012","BSIT-0013","BSIT-0014","BSIT-0015","BSIT-0016","BSIT-0017",
  "BSIT-0018","BSIT-0019","BSIT-0020"];
  List<String> donew2 = ["BSIT-001","BSIT-002","BSIT-003","BSIT-004","BSIT-005","BSIT-006","BSIT-007",//window2
     "BSIT-008","BSIT-009","BSIT-010"];

  List<String> cancelledw3 = ["ENGR-0021","ENGR-0022","ENGR-0023","ENGR-0024","ENGR-0025","ENGR-0026","ENGR-0027",
  "ENGR-0028","ENGR-0029","ENGR-0030"];
  List<String> qw3 = ["ENGR-0011","ENGR-0012","ENGR-0013","ENGR-0014","ENGR-0015","ENGR-0016","ENGR-0017",
  "ENGR-0018","ENGR-0019","ENGR-0020"];
  List<String> donew3 = ["ENGR-001","ENGR-002","ENGR-003","ENGR-004","ENGR-005","ENGR-006","ENGR-007",//window3
     "ENGR-008","ENGR-009","ENGR-010"];

  List<String> cancelledw4 = ["BSBA-0021","BSBA-0022","BSBA-0023","ACC-0024","ACC-0025","BAIS-0026","BSBA-0027",
  "BSBA-0028","BAIS-0029","ACC-0030"];
  List<String> qw4 = ["ACC-0011","ACC-0012","BSBA-0013","BSBA-0014","BSBA-0015","BSBA-0016","BAIS-0017",
  "BAIS-0018","BAIS-0019","ACC-0020"];
  List<String> donew4 = ["BSBA-001","BSBA-002","BSBA-003","ACC-004","ACC-005","ACC006","BAIS-007",//window4
     "BAIS-008","ACC-009","BSBA-010"];

  List<String> cancelledw5 = [];//window5
  List<String> qw5 = [];
  List<String> donew5 = [];

  List<String> cancelledw6 = [];//window6
  List<String> qw6 = [];
  List<String> donew6 = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // constraints provide us with maxWidth,maxHeight etc, using
          // which we can show different widgets accordingly
          if (constraints.maxWidth >= 768)
          {
            return _qwScreen1();//desktop
          } 
          else
          {
            return _qwScreen2();
          }
        },
    );
  }

  Widget _qwScreen1()//navigation - desktop view
  {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 6),
              ButtonsTabBar(
                backgroundColor: Color.fromARGB(255, 14, 111, 141),
                contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 37, 37, 37), fontFamily: "CGothic",),
                labelStyle:
                    const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "CGothic",
                    ),
                    height: 56,
                tabs: const [
                  Tab(
                    text: "WINDOW 1",
                  ),
                  Tab(
                    text: "WINDOW 2",
                  ),
                  Tab(
                    text: "WINDOW 3",
                  ),
                  Tab(
                    text: "WINDOW 4",
                  ),
                  Tab(
                    text: "WINDOW 5",
                  ),
                  Tab(
                    text: "WINDOW 6",
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Divider(
                  color: Color.fromARGB(255, 58, 110, 153),
                  thickness: 3.0,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: _windowSc1(cancelledw1, qw1, donew1)
                    ),
                    Center(
                      child: _windowSc1(cancelledw2, qw2, donew2)
                    ),
                    Center(
                      child: _windowSc1(cancelledw3, qw3, donew3)
                    ),
                    Center(
                      child: _windowSc1(cancelledw4, qw4, donew4)
                    ),
                    Center(
                      child: _windowSc1(cancelledw5, qw5, donew5)
                    ),
                    Center(
                      child: _windowSc1(cancelledw6, qw6, donew6)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qwScreen2()//navigation
  {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 6),
              ButtonsTabBar(
                backgroundColor: Color.fromARGB(255, 14, 111, 141),
                contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 37, 37, 37), fontFamily: "CGothic",),
                labelStyle:
                    const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "CGothic",
                    ),
                    height: 56,
                tabs: const [
                  Tab(
                    text: "WINDOW 1",
                  ),
                  Tab(
                    text: "WINDOW 2",
                  ),
                  Tab(
                    text: "WINDOW 3",
                  ),
                  Tab(
                    text: "WINDOW 4",
                  ),
                  Tab(
                    text: "WINDOW 5",
                  ),
                  Tab(
                    text: "WINDOW 6",
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Divider(
                  color: Color.fromARGB(255, 58, 110, 153),
                  thickness: 3.0,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: _windowSc2(cancelledw1, qw1, donew1)
                    ),
                    Center(
                      child: _windowSc2(cancelledw2, qw2, donew2)
                    ),
                    Center(
                      child: _windowSc2(cancelledw3, qw3, donew3)
                    ),
                    Center(
                      child: _windowSc2(cancelledw4, qw4, donew4)
                    ),
                    Center(
                      child: _windowSc2(cancelledw5, qw5, donew5)
                    ),
                    Center(
                      child: _windowSc2(cancelledw6, qw6, donew6)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _windowSc1(cancelled, q, done)//desktop view
  {
      return SingleChildScrollView(
        primary: false,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(//cancelled list
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                child: Card(
                                  color: Color.fromARGB(255, 47, 148, 179),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: ListTile(
                                          title: Text(
                                            "CANCELLED",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                            ),
                                        ),
                                      ),
                                    ),
                              ),
                              Container(
                                height: 400,
                                child: ListView.builder(
                                  controller: ScrollController(),
                                  itemBuilder: (BuildContext, index){
                                    return Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color.fromARGB(255, 58, 110, 153), width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text("${cancelled[index]}"),
                                      ),
                                    );
                                  },
                                  itemCount: cancelled.length,
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),

                    Expanded(//Queue list
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                child: Card(
                                  color: Color.fromARGB(255, 47, 148, 179),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: ListTile(
                                          title: Text(
                                            "QUEUE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                            ),
                                        ),
                                      ),
                                    ),
                              ),
                              Container(
                                height: 400,
                                child: ListView.builder(
                                  controller: ScrollController(),
                                  itemBuilder: (BuildContext, index){
                                    return Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color.fromARGB(255, 58, 110, 153), width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text("${q[index]}"),
                                      ),
                                    );
                                  },
                                  itemCount: q.length,
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),

                    Expanded(//done list
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                child: Card(
                                  color: Color.fromARGB(255, 47, 148, 179),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: ListTile(
                                          title: Text(
                                            "DONE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                            ),
                                        ),
                                      ),
                                    ),
                              ),
                              Container(
                                height: 400,
                                child: ListView.builder(
                                  controller: ScrollController(),
                                  itemBuilder: (BuildContext, index){
                                    return Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color.fromARGB(255, 58, 110, 153), width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text("${done[index]}"),
                                      ),
                                    );
                                  },
                                  itemCount: done.length,
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(//total cancelled
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  child: Row(
                    children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 14, 111, 141),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              child: Row(
                                  children:[
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          "TOTAL:",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${cancelled.length}",
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Color.fromARGB(255, 41, 41, 41),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ),

                        Expanded(//total queue
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 14, 111, 141),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              child: Row(
                                  children:[
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          "TOTAL:",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${q.length}",
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Color.fromARGB(255, 41, 41, 41),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ),

                        Expanded(//total done
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 14, 111, 141),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              child: Row(
                                  children:[
                                    const Expanded(
                                      child: Center(
                                        child: Text(
                                          "TOTAL:",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${done.length}",
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Color.fromARGB(255, 41, 41, 41),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget _windowSc2(cancelled, q, done)
  {
      return SingleChildScrollView(
        primary: false,
        child: Container(
          child: Column(
            children: [
               Container(//Cancelled
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Column(
                           children: [
                             Container(
                               height: 70,
                               child: Card(
                                 color: Color.fromARGB(255, 47, 148, 179),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: const Center(
                                       child: ListTile(
                                         title: Text(
                                           "CANCELLED",
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                             fontSize: 25,
                                             color: Colors.white,
                                           ),
                                           ),
                                       ),
                                     ),
                                   ),
                             ),
                             Container(
                               height: 400,
                               child: ListView.builder(
                                 controller: ScrollController(),
                                 itemBuilder: (BuildContext, index){
                                   return Card(
                                     color: Colors.white,
                                     shape: RoundedRectangleBorder(
                                       side: BorderSide(color: Color.fromARGB(255, 58, 110, 153), width: 2),
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: ListTile(
                                       title: Text("${cancelled[index]}"),
                                     ),
                                   );
                                 },
                                 itemCount: cancelled.length,
                                 padding: const EdgeInsets.symmetric(vertical: 5),
                               ),
                             ),
                           ],
                         )
                       ),
                     ),
                     Padding(//total cancelled
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       child: Container(
                         height: 60,
                         decoration: BoxDecoration(
                             color: Color.fromARGB(255, 14, 111, 141),
                             borderRadius: BorderRadius.circular(10),
                           ),
                         child: Row(
                             children:[
                               const Expanded(
                                 child: Center(
                                   child: Text(
                                     "TOTAL:",
                                     style: TextStyle(
                                       fontSize: 25,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 flex: 2,
                                 child: Center(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Container(
                                         height: 40,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius: BorderRadius.circular(10),
                                         ),
                                         child: Center(
                                           child: Text(
                                             "${cancelled.length}",
                                             style: const TextStyle(
                                               fontSize: 25,
                                               color: Color.fromARGB(255, 41, 41, 41),
                                             ),
                                           ),
                                         ),
                                       ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                       ),
                     ),
                   ],
                 )
               ),
               const SizedBox(height: 20),
               Container(//queue
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Column(
                           children: [
                             Container(
                               height: 70,
                               child: Card(
                                 color: Color.fromARGB(255, 47, 148, 179),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: const Center(
                                       child: ListTile(
                                         title: Text(
                                           "QUEUE",
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                             fontSize: 25,
                                             color: Colors.white,
                                           ),
                                           ),
                                       ),
                                     ),
                                   ),
                             ),
                             Container(
                               height: 400,
                               child: ListView.builder(
                                 controller: ScrollController(),
                                 itemBuilder: (BuildContext, index){
                                   return Card(
                                     color: Colors.white,
                                     shape: RoundedRectangleBorder(
                                       side: BorderSide(color: Color.fromARGB(255, 58, 110, 153), width: 2),
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: ListTile(
                                       title: Text("${q[index]}"),
                                     ),
                                   );
                                 },
                                 itemCount: cancelled.length,
                                 padding: const EdgeInsets.symmetric(vertical: 5),
                               ),
                             ),
                           ],
                         )
                       ),
                     ),
                     Padding(//total queue
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       child: Container(
                         height: 60,
                         decoration: BoxDecoration(
                             color: Color.fromARGB(255, 14, 111, 141),
                             borderRadius: BorderRadius.circular(10),
                           ),
                         child: Row(
                             children:[
                               const Expanded(
                                 child: Center(
                                   child: Text(
                                     "TOTAL:",
                                     style: TextStyle(
                                       fontSize: 25,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 flex: 2,
                                 child: Center(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Container(
                                         height: 40,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius: BorderRadius.circular(10),
                                         ),
                                         child: Center(
                                           child: Text(
                                             "${q.length}",
                                             style: const TextStyle(
                                               fontSize: 25,
                                               color: Color.fromARGB(255, 41, 41, 41),
                                             ),
                                           ),
                                         ),
                                       ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                       ),
                     ),
                   ],
                 ),
               ),

               const SizedBox(height: 20),
               Container(//done
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Column(
                           children: [
                             Container(
                               height: 70,
                               child: Card(
                                 color: Color.fromARGB(255, 47, 148, 179),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: const Center(
                                       child: ListTile(
                                         title: Text(
                                           "DONE",
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                             fontSize: 25,
                                             color: Colors.white,
                                           ),
                                           ),
                                       ),
                                     ),
                                   ),
                             ),
                             Container(
                               height: 400,
                               child: ListView.builder(
                                 controller: ScrollController(),
                                 itemBuilder: (BuildContext, index){
                                   return Card(
                                     color: Colors.white,
                                     shape: RoundedRectangleBorder(
                                       side: BorderSide(color: Color.fromARGB(255, 58, 110, 153), width: 2),
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: ListTile(
                                       title: Text("${q[index]}"),
                                     ),
                                   );
                                 },
                                 itemCount: cancelled.length,
                                 padding: const EdgeInsets.symmetric(vertical: 5),
                               ),
                             ),
                           ],
                         )
                       ),
                     ),
                     Padding(//total done
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       child: Container(
                         height: 60,
                         decoration: BoxDecoration(
                             color: Color.fromARGB(255, 14, 111, 141),
                             borderRadius: BorderRadius.circular(10),
                           ),
                         child: Row(
                             children:[
                               const Expanded(
                                 child: Center(
                                   child: Text(
                                     "TOTAL:",
                                     style: TextStyle(
                                       fontSize: 25,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 flex: 2,
                                 child: Center(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Container(
                                         height: 40,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius: BorderRadius.circular(10),
                                         ),
                                         child: Center(
                                           child: Text(
                                             "${done.length}",
                                             style: const TextStyle(
                                               fontSize: 25,
                                               color: Color.fromARGB(255, 41, 41, 41),
                                             ),
                                           ),
                                         ),
                                       ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                       ),
                     ),
                   ],
                 ),
               ),
            ]
          ),
        ),
      );
  }

}