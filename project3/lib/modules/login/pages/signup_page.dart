import 'package:flutter/material.dart';

void main() {
  runApp(const SignupWidget());
}

class SignupWidget extends StatelessWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Queuing System",
      home: Center(
        child: MyHomePage(
          title: ('Sign up'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 81, 0),
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 50, color: Colors.white, fontFamily: 'Raleway'),
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
