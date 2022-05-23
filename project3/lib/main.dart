import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:project3/dashboard.dart';
import 'package:project3/monitor.dart';
import 'package:project3/qwing_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "CGothic",
      ),
      home: MyHomePage(title: 'Admin'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 300,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 20,
              width: 20,
              child: Image.asset('images/logo.png'),
            ),
          ),
        title: const Text("Q-WING"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          toolbarHeight: 100,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedColor: Color.fromARGB(255, 14, 111, 141),
              unselectedTitleTextStyle: const TextStyle(fontSize: 20,),
              selectedTitleTextStyle: const TextStyle(color: Colors.white, fontSize: 20,),
              selectedIconColor: Colors.white,    
              backgroundColor: Colors.white,
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Color.fromARGB(255, 201, 201, 201), width: 3))
              ),
              compactSideMenuWidth: 60,
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Dashboard',
                onTap: () {
                  page.jumpToPage(0);
                },
                icon: const Icon(Icons.dashboard),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Q-WING Lists',
                onTap: () {
                  page.jumpToPage(1);
                },
                icon: const Icon(Icons.feed_outlined ),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Monitor',
                onTap: () {
                  page.jumpToPage(2);
                },
                icon: const Icon(Icons.monitor),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Window',
                onTap: () {
                  page.jumpToPage(3);
                },
                icon: const Icon(Icons.sensor_window_rounded),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Report',
                onTap: () {
                  page.jumpToPage(4);
                },
                icon: const Icon(Icons.analytics_outlined),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Logout',
                onTap: () async {},
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: dashboard(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: qwingList(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: const Center(
                    child: monitor(),
                  ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}