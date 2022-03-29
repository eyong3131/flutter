import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_test/json/patient_json.dart';
// ignore: unused_import
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
  late List<PatientJson> json;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    var url = Uri.parse('http://192.168.1.12:3000/api/patient');
    var client = http.Client();
    var response = await client.post(url);
    if (response.statusCode == 200) {
      setState(() {
        json = patientJsonFromJson(response.body);
        _isloading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _listView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: json.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text('Id : ${json[index].id}')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingFour(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Data Table Test")),
      body: _isloading ? spinkit : _listView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _loadData();
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
