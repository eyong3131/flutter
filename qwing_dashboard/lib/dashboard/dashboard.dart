import 'package:flutter/material.dart';
import "package:hovering/hovering.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _key = GlobalKey<ScaffoldState>();

  _WidgetScale(bool isText) {
    double? scale;
    if (isText) {
      //still dont know how to properly implement this screens
      if (MediaQuery.of(context).size.height >= 720 ||
          MediaQuery.of(context).size.height <= 1024) {
        scale = MediaQuery.of(context).size.height * 0.10;
      }
    } else {
      if (MediaQuery.of(context).size.height >= 720 ||
          MediaQuery.of(context).size.height <= 1024) {
        scale = MediaQuery.of(context).size.height * 0.20;
      }
    }
    return scale;
  }

  Widget listContainer(ListTile) => HoverWidget(
        hoverChild: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 130, 180, 223),
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
          ),
          child: ListTile,
        ),
        onHover: (event) {},
        child: ListTile,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Qwing - Dashboard",
            style: TextStyle(
              fontSize: _WidgetScale(true) * 0.60,
            )),
        toolbarHeight: _WidgetScale(false) * 0.60,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[100],
              ),
              child: Text("Drawer Heading",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
            ),
            listContainer(
              ListTile(
                leading: const Icon(Icons.add_chart),
                title: Text("Dashboard",
                    style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
                onTap: () {
                  print("Qwing Dashboard");
                  Navigator.pop(context);
                  /*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const second.SecondRoute()),
                );
                */
                },
              ),
            ),
            listContainer(ListTile(
              leading: const Icon(Icons.list_alt_outlined),
              title: Text("Qwing - list",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Qwing List");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.monitor_weight_outlined),
              title: Text("Monitor",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Monitor");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.window_outlined),
              title: Text("Window",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Window");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text("Logout",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Logout");
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }
}
