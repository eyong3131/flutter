import 'package:app1/employeeModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<EmployeeModel> json;

  //iniState
  @override
  void initState() {
    super.initState();
    //loadData();
  }

  //load data
  void loadData() async {
    //http request
    var bytes = convert.utf8.encode('minhs:minhs');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };

    //var body = convert.json.encode({'id': id, 'date': date, 'time': time});
    var url = Uri.parse('http://66.94.102.243:3000/api/employee');
    var client = http.Client();
    var response = await client.post(url, headers: header);

    if (response.statusCode == 200) {
      json = employeeModelFromJson(response.body);
      for (var item in json) {
        // ignore: avoid_print
        print(item.lastname);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMPLOYEE'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: json.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50,
                child:
                    Center(child: Text('LastName : ${json[index].lastname}')),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadData();
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
