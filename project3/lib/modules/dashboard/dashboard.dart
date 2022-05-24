import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class dashboard extends StatefulWidget {
  const dashboard({ Key? key }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  int cancel_w1 = 5, q_w1 = 21, done_w1 = 19; //dummy data for dashboard (window 1-6)
  int cancel_w2 = 7, q_w2 = 12, done_w2 = 29;
  int cancel_w3 = 12, q_w3 = 30, done_w3 = 9;
  int cancel_w4 = 2, q_w4 = 34, done_w4 = 17;
  int cancel_w5 = 0, q_w5 = 0, done_w5 = 0;
  int cancel_w6 = 0, q_w6 = 0, done_w6 = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // constraints provide us with maxWidth,maxHeight etc, using
          // which we can show different widgets accordingly
          if (constraints.maxWidth >= 768)
          {
            return _dbScreen1();//desktop
          } 
          else
          {
            return _dbScreen2();
          }
        },
    );
  }

  Widget _dbScreen1() //navigation
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
                      child: _windowSc1(cancel_w1, q_w1, done_w1)
                    ),
                    Center(
                      child: _windowSc1(cancel_w2, q_w2, done_w2)
                    ),
                    Center(
                      child: _windowSc1(cancel_w3, q_w3, done_w3)
                    ),
                    Center(
                      child: _windowSc1(cancel_w4, q_w4, done_w4)
                    ),
                    Center(
                      child: _windowSc1(cancel_w5, q_w5, done_w5)
                    ),
                    Center(
                      child: _windowSc1(cancel_w6, q_w6, done_w6)
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

  Widget _dbScreen2()
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
                      child: _windowSc2(cancel_w1, q_w1, done_w1)
                    ),
                    Center(
                      child: _windowSc2(cancel_w2, q_w2, done_w2)
                    ),
                    Center(
                      child: _windowSc2(cancel_w3, q_w3, done_w3)
                    ),
                    Center(
                      child: _windowSc2(cancel_w4, q_w4, done_w4)
                    ),
                    Center(
                      child: _windowSc2(cancel_w5, q_w5, done_w5)
                    ),
                    Center(
                      child: _windowSc2(cancel_w6, q_w6, done_w6)
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

  Widget _windowSc1(cancel, q, done)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            const SizedBox(height:30),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(//CANCELLED
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 5),
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 14, 111, 141),
                            ),
                            child: const Center(
                              child: Text(
                                "CANCEL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 14, 111, 141),
                                width: 12,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(200))
                            ),
                            child: Center(
                              child: Text(
                                "$cancel",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 78, 78, 78),
                                fontSize: 80,
                                ),
                              ),
                            ),
                          ),
                        ],
                    ),
                    ),
                  ),
                  
                  Expanded(
                    child: Container(//QUEUE
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 5),
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 14, 111, 141),
                            ),
                            child: const Center(
                              child: Text(
                                "QUEUE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 290,
                            height: 290,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 14, 111, 141),
                                width: 12,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(200))
                            ),
                            child: Center(
                              child: Text(
                                "$q",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 78, 78, 78),
                                fontSize: 90,
                                ),
                              ),
                            ),
                          ),
                        ],
                    ),
                    ),
                  ),

                  Expanded(
                    child: Container(//DONE
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 5),
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 14, 111, 141),
                            ),
                            child: const Center(
                              child: Text(
                                "DONE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 14, 111, 141),
                                width: 12,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(200))
                            ),
                            child: Center(
                              child: Text(
                                "$done",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 78, 78, 78),
                                fontSize: 80,
                                ),
                              ),
                            ),
                          ),
                        ],
                    ),
                    ),
                  )
                  
                ],
              ),

            ),
          ]
        ),
      ),
    );
  }

  Widget _windowSc2(cancel, q, done)
  {
    return Container(
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Container(//CANCELLED
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 5),
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 14, 111, 141),
                      ),
                      child: const Center(
                        child: Text(
                          "CANCEL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromARGB(255, 14, 111, 141),
                          width: 12,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(200))
                      ),
                      child: Center(
                        child: Text(
                          "$cancel",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 78, 78, 78),
                          fontSize: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
            ),
            ),
            const SizedBox(height: 30,),
            Container(//QUEUE
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 5),
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 14, 111, 141),
                      ),
                      child: const Center(
                        child: Text(
                          "QUEUE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromARGB(255, 14, 111, 141),
                          width: 12,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(200))
                      ),
                      child: Center(
                        child: Text(
                          "$q",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 78, 78, 78),
                          fontSize: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
            ),
            ),
            const SizedBox(height: 30,),
            Container(//QUEUE
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 5),
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 14, 111, 141),
                      ),
                      child: const Center(
                        child: Text(
                          "DONE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromARGB(255, 14, 111, 141),
                          width: 12,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(200))
                      ),
                      child: Center(
                        child: Text(
                          "$done",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 78, 78, 78),
                          fontSize: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
            ),
            ),
          ]
        ),
      )
    );
  }
}