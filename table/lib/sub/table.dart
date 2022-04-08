import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'dart:convert' as convert;
import '../json/patient_json.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class myTable extends StatefulWidget {
  const myTable({Key? key}) : super(key: key);

  @override
  State<myTable> createState() => _myTableState();
}

// ignore: camel_case_types
class _myTableState extends State<myTable> {
  late List<PatientJson> json;
  bool _isloading = true;
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //calling in iniit the function
    //tried removing it here since i had setState function in loadData() and though it will be triggered but it did not
    _loadData();
  }

  void _loadData() async {
    var url = Uri.parse('http://192.168.1.12:3000/api/patient');
    var client = http.Client();
    var response = await client.post(url);
    if (response.statusCode == 200) {
      //tried also removing the setState here but it is not loading the json so i had to bring it back here
      setState(() {
        json = patientJsonFromJson(response.body);
        _isloading = false;
      });
    }
  }

  //Widget Function for list of the data table
  Widget _listView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            // ignore: sized_box_for_whitespace
            child: Container(
          height: 30.0,
          child: Row(
            children: [
              AppBar(
                title: const Text("Test Label"),
              ),
              AppBar(
                title: const Text("Test Label"),
              ),
              AppBar(
                title: const Text("Test Label"),
              ),
            ],
          ),
        )),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: json.length,
                itemBuilder: (BuildContext context, int index) {
                  return Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      // Telling specific cells which column style going to be used
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                    },
                    //alignments for the row and columns
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Center(
                              child: SizedBox(
                            width: 32,
                            height: 32,
                            child: Text("${json[index].id}"),
                          )),
                          Center(
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: Text("${json[index].pId}"),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 115,
                              height: 32,
                              child: Text("${json[index].illness}"),
                            ),
                          ),
                          Center(
                              child: SizedBox(
                            width: 32,
                            height: 32,
                            child: IconButton(
                              iconSize: 24,
                              onPressed: () {
                                _passData("${json[index].id}");
                                _loadData();
                              },
                              icon: const Icon(Icons.favorite),
                            ),
                          ))
                        ],
                      ),
                    ],
                  );
                })),
      ],
    );
  }

  _passData(String? id) async {
    //header
    var bytes = convert.utf8.encode('viral:viral');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //body and url
    var body = convert.json.encode({'id': id});
    var url = Uri.parse('http://192.168.1.12:3000/api/patient/remove');
    var client = http.Client();
    var response = await client.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("$id");
    }
  }

  // i dont know why it is needed but it is always a good practice to remove unnecesary stuff after being used.
  @override
  void dispose() {
    super.dispose();
  }

  //Loading Icon before the json list can be loaded
  final spinkit = SpinKitFadingFour(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Data Table"),
      ),
      //ternary for checking if the json list is ready or not
      body: _isloading ? spinkit : _listView(),
    );
  }
}
