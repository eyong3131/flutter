import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:node_test/json/patient_json.dart';
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
  // ignore: unused_field
  bool _isloading = true;

  //late String _id;
  late String _name;
  late String _lastName;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //_loadData();
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

  void _passData() async {
    //header
    var bytes = convert.utf8.encode('viral:viral');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //body and url
    var body = convert.json.encode({'name': _name, 'lname': _lastName});
    var url = Uri.parse('http://192.168.1.12:3000/api/patient/payload');
    var client = http.Client();
    var response = await client.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("im working");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: unused_element
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

  // ignore: non_constant_identifier_names
  Widget _NameField() {
    return TextFormField(
      //controller: inputController,
      decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
          hintText: "Enter your Name here!"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return _name = "Please Enter Name";
        } else {
          _name = value;
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _lname() {
    return TextFormField(
      //controller: inputController,
      decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
          hintText: "Enter your Name here!"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return _lastName = "Please Enter Name";
        } else {
          _lastName = value;
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NameField(),
            _lname(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  //node test
                  _passData();
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("name is: $_name  \n Last Name is: $_lastName"),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      //body: _isloading ? spinkit : _listView(), ternary for loading delayed json querry inside widget
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
