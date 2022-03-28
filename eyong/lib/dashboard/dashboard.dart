import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Viral Disease Monitoring System",
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Text("Title of Panel"),
            ),
          ],
        ),
      ),
    );
  }
}
