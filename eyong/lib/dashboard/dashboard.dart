import 'package:eyong/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:hovering/hovering.dart";
import '../map_class/maps.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerSet(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Viral Disease Monitoring System",
            style: TextStyle(
                fontSize: _WidgetScale(true) * 0.60, color: Colors.black)),
        toolbarHeight: _WidgetScale(false) * 0.60,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SizedBox(
          width: _WidgetScale(false) * 12.0,
          height: _WidgetScale(false),
          child: Mapbox()),
    );
  }

  // ignore: non_constant_identifier_names, prefer_const_constructors
  Widget SpcMap() => SizedBox(
        width: _WidgetScale(false),
        height: _WidgetScale(false),
      );

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

  Widget DrawerSet() => Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: SizedBox(
                width: _WidgetScale(false),
                height: _WidgetScale(false),
                child: Image.asset('assets/img/spc.png'),
              ),
            ),
            listContainer(
              ListTile(
                leading: const Icon(Icons.add_chart),
                title: Text("Dashboard",
                    style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
                onTap: () {
                  print("Dashboard");
                  Navigator.pop(context);
                },
              ),
            ),
            listContainer(ListTile(
              leading: const Icon(Icons.document_scanner_outlined),
              title: Text("Documents",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Documents");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.auto_graph_outlined),
              title: Text("Graphs",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Graphs");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.add_alert_outlined),
              title: Text("Alert",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("Alert");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.info_outlined),
              title: Text("About",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                print("About");
                Navigator.pop(context);
              },
            )),
            listContainer(ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text("Logout",
                  style: TextStyle(fontSize: _WidgetScale(true) * 0.30)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            )),
          ],
        ),
      );
}
