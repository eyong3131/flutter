import 'package:flutter/material.dart';
import './qr/qr_scanner.dart';
import './qr/qr_generator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController controller;
  final inputController = TextEditingController();

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid View"),
        backgroundColor: const Color(0xFF019875),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF019875),
        child: TabBar(
          labelColor: Colors.black,
          controller: controller,
          indicatorWeight: 5.0,
          //indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.pink,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.qr_code),
            ),
            Tab(
              icon: Icon(Icons.qr_code_scanner),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const <Widget>[
          qrGenerator(),
          qrScanner(),
        ],
      ),
    );
  }
}
