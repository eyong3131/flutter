import 'package:flutter/material.dart';

class QueueNum extends StatefulWidget {
  final String qnum;

  const QueueNum({Key? key, required this.qnum}) : super(key: key);

  @override
  State<QueueNum> createState() => _QueueNumState();
}

class _QueueNumState extends State<QueueNum> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // constraints provide us with maxWidth,maxHeight etc, using
        // which we can show different widgets accordingly
        if (constraints.maxWidth <= 768) //mobile
        {
          return _qscreen1();
        } else //desktop
        {
          return _qscreen2();
        }
      },
    );
  }

  Widget _qscreen1() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, //remove back arrow after navigation
        centerTitle: true,
        title: const Text(
          "Q-WING",
        ),
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: "CGothic",
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  width: double.infinity,
                  child: const Text(
                    "YOUR TRANSACTION\nNUMBER IS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "CGothic",
                    ),
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 7),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Text(widget.qnum,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 150, 54, 16),
                        fontFamily: "CGothic",
                      )),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  width: double.infinity,
                  child: const Text(
                    "PLEASE CHECK THE TRANSACTION NUMBER THAT APPEARS ON THE SCREEN AT ALL TIMES.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontFamily: "CGothic",
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(
                          50), // fromHeight use double.infinity as width and 40 is the height
                      primary: Color.fromARGB(206, 21, 80, 128),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "CGothic",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _qscreen2() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 500,
        leading: Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Text(
                  "MAY 01,2022",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                child: const Text(
                  "11:03 AM",
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Q-WING",
        ),
        titleTextStyle: const TextStyle(
          fontSize: 60,
          fontFamily: "CGothic",
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      child: const Text(
                        "YOUR TRANSACTION NUMBER IS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "CGothic",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: 500,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 15),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Text(widget.qnum,
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 150, 32, 16),
                            fontFamily: "CGothic",
                          )),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      width: double.infinity,
                      child: const Text(
                        "PLEASE CHECK THE TRANSACTION NUMBER THAT\nAPPEARS ON THE SCREEN AT ALL TIMES.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                          fontFamily: "CGothic",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(
                              80), // fromHeight use double.infinity as width and 40 is the height
                          primary: Color.fromARGB(206, 21, 80, 128),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: "CGothic",
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
