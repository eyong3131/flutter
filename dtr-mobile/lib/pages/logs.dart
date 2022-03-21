// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:minhs/common/constantHelper.dart';
import 'package:minhs/common/databaseHelper.dart';
import 'package:minhs/model/employeesModel.dart';
import 'package:minhs/model/logsModel.dart';
import 'package:minhs/model/settingsModel.dart';
import 'package:minhs/pages/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key}) : super(key: key);

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final databaseHelper = DatabaseHelper.instance;
  late TextEditingController _controller1;
  late TextEditingController _controller2;

  List<EmployeesModel> employeeList = [];
  List<LogsModel> logsList = [];
  SettingsModel settings = SettingsModel();

  bool _isLoading = false;
  String _strLoading = "";
  String _dateFrom = "";
  String _dateTo = "";

  @override
  void initState() {
    super.initState();

    _dateFrom = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _dateTo = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _controller1 = TextEditingController(text: DateTime.now().toString());
    _controller2 = TextEditingController(text: DateTime.now().toString());

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _isLoading = false;
    _strLoading = "";
  }

  void loadData() async {
    setState(() {
      _strLoading = "";
      _isLoading = true;
    });

    try {
      await loadSettings();
      await loadEmployees();
      await loadLogs();
    } on Exception catch (e) {
      print('Exception Error');
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> loadSettings() async {
    try {
      final localDB = await databaseHelper.database;

      //get settings
      var query = await localDB!.rawQuery(
          'select site, interval, apiurl, username, password from settings');

      for (final item in query) {
        settings.site = item["site"].toString();
        settings.interval = item["interval"].toString();
        settings.apiurl = item["apiurl"].toString();
        settings.username = item["username"].toString();
        settings.password = item["password"].toString();
      }
    } on Exception catch (e) {
      print('Exception Error');
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadEmployees() async {
    try {
      final localDB = await databaseHelper.database;
      //get employee
      var query = await localDB!.rawQuery(
          'select id, name, firstname, middlename, lastname, position, image, email, hash from employee order by lastname, firstname, middlename');

      employeeList = [];
      for (final item in query) {
        var tmp = {
          "id": item["id"],
          "name": item["name"].toString().toUpperCase(),
          "firstname": item["firstname"],
          "middlename": item["middlename"],
          "lastname": item["lastname"],
          "image": item["image"],
          "position": item["position"],
          "email": item["email"],
          "hash": item["hash"],
        };

        var obj = EmployeesModel.fromJson(tmp);
        employeeList.add(obj);
      }
    } on Exception catch (e) {
      print('Exception Error');
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> loadLogs() async {
    try {
      print('loadLogs');

      final localDB = await databaseHelper.database;
      //get employee
      var query = await localDB!.rawQuery(
          "select id, date, time, status from empdtr where date between '$_dateFrom' and '$_dateTo' order by date, time DESC");

      logsList = [];
      for (final item in query) {
        var tmp = {
          "id": item["id"],
          "date": item["date"],
          "time": item["time"],
          "status": item["status"]
        };

        var obj = LogsModel.fromJson(tmp);

        for (var item in employeeList) {
          if (item.id == obj.id) {
            obj.name = item.name;
            obj.image = item.image;
            break;
          }
        }

        setState(() {
          _strLoading = obj.name!;
        });

        logsList.add(obj);
      }
    } on Exception catch (e) {
      print('Exception Error');
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void syncData() async {
    try {
      final localDB = await databaseHelper.database;

      //get employee
      //insert into employee sqlite
      setState(() {
        _strLoading = "Sync Data...";
        _isLoading = true;
      });

      for (var item in logsList) {
        if (item.status != "1") {
          setState(() {
            _strLoading = item.name!;
          });

          var bytes =
              convert.utf8.encode('${settings.username}:${settings.password}');
          var base64Str = convert.base64.encode(bytes);

          var header = {
            "Content-type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic $base64Str",
          };

          var body = convert.json
              .encode({'id': item.id, 'date': item.date, 'time': item.time});

          var url = Uri.parse('${settings.apiurl}/api/dtr/sync');
          var client = http.Client();
          var response = await client.post(url, body: body, headers: header);
          if (response.statusCode == 200) {
            //update empdtr
            await localDB?.rawInsert(
                'update empdtr set status = 1 where id = ? and date = ? and time = ?',
                [item.id, item.date, item.time]);
          }
        }
      }

      loadData();

      // setState(() {
      //   _isLoading = false;
      // });

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kSuccessDialog(context, "Sync Complete"));
    } on Exception catch (e) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    } catch (e) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    }
  }

  Widget _displayImage(image) {
    if (image != "") {
      return Image.memory(
        convert.Base64Decoder().convert(image),
        fit: BoxFit.fill,
        // height: 120,
        // width: 120,
      );
    } else {
      return Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.fill,
        // height: 120,
        // width: 120,
      );
    }
  }

  Widget _showDateTimePickerDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 70, 10, 15),
              child: Column(
                children: [
                  Text(
                    'SELECT DATE RANGE',
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      //color: Colors.greenAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    controller: _controller1,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date From',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    controller: _controller2,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date To',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "OK",
                        style: GoogleFonts.lato(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kLightColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _dateFrom = _controller1.text;
                        _dateTo = _controller2.text;
                        Navigator.pop(context);
                        loadData();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            child: ClipRRect(
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text('Material Dialog'),
    //         content: Card(
    //           child: Column(
    //             children: [
    //               DateTimePicker(
    //                 type: DateTimePickerType.date,
    //                 dateMask: 'd MMM, yyyy',
    //                 controller: _controller1,
    //                 //initialValue: _initialValue,
    //                 firstDate: DateTime(2000),
    //                 lastDate: DateTime(2100),
    //                 icon: Icon(Icons.event),
    //                 dateLabelText: 'Date',
    //                 // selectableDayPredicate: (date) {
    //                 //   if (date.weekday == 6 || date.weekday == 7) {
    //                 //     return false;
    //                 //   }
    //                 //   return true;
    //                 // },
    //                 // onChanged: (val) => setState(() => _valueChanged1 = val),
    //                 // validator: (val) {
    //                 //   setState(() => _valueToValidate1 = val ?? '');
    //                 //   return null;
    //                 // },
    //                 // onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
    //               ),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //               onPressed: () {
    //                 // _dismissDialog();
    //               },
    //               child: Text('Close')),
    //           TextButton(
    //             onPressed: () {
    //               // print('HelloWorld!');
    //               // _dismissDialog();
    //             },
    //             child: Text('HelloWorld!'),
    //           )
    //         ],
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            'Logs',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitFadingCircle(
                      color: kPrimaryColor,
                      size: 50.0,
                    ),
                    _strLoading == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              _strLoading,
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      drawer: const MenuPage(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Logs',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync Logs',
            onPressed: () {
              syncData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Date Range',
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      _showDateTimePickerDialog());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: logsList.length,
          itemBuilder: (context, index) {
            // var txnDate = "";
            // var txnDesc = "";

            // // print('${logsList[index].txn_id} : ${logsList[index].txn_id}');
            // // print('${logsList[index].txn_id} : ${logsList[index].txn_date}');
            // // print('${logsList[index].txn_id} : ${logsList[index].txn_desc}');
            // // print('${logsList[index].txn_id} : ${logsList[index].txn_time}');
            // // print('${logsList[index].txn_id} : ${logsList[index].image}');

            // if (logsList[index].txn_date != null) {
            //   txnDate = logsList[index].txn_date!;
            // }

            // if (logsList[index].txn_desc != null) {
            //   txnDesc = logsList[index].txn_desc!;
            // }

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {},
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employee: ${logsList[index].name}',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Log Date: ${logsList[index].date}',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Log Time: ${logsList[index].time}',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Status: ${logsList[index].status == "1" ? "Synced" : "Pending"}',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  leading: ClipRRect(
                    child: _displayImage(logsList[index].image ?? ""),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
