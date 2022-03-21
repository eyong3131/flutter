// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhs/common/constantHelper.dart';
import 'package:minhs/common/databaseHelper.dart';
import 'package:minhs/model/empImage.dart';
import 'package:minhs/model/employeesModel.dart';
import 'package:minhs/model/settingsModel.dart';
import 'package:minhs/pages/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// import 'package:crypto/crypto.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final _databaseHelper = DatabaseHelper.instance;

  List<EmployeesModel> employeeList = [];
  SettingsModel settings = SettingsModel();
  bool isLoading = false;
  String strLoading = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() async {
    setState(() {
      isLoading = true;
      strLoading = "Loading...";
    });

    try {
      await loadSettings();
      await loadEmployees();
    } on Exception catch (e) {
      print('Exception Error');
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    print('mounted');
    if (mounted) {
      setState(() {
        isLoading = false;
        strLoading = "";
      });
    }
  }

  Future<void> loadSettings() async {
    try {
      final localDB = await _databaseHelper.database;

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
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadEmployees() async {
    try {
      final localDB = await _databaseHelper.database;

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

        setState(() {
          strLoading = obj.name!;
        });

        employeeList.add(obj);
      }

      setState(() {
        strLoading = "Finalizing...";
      });
    } on Exception catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void syncData(context) async {
    setState(() {
      isLoading = true;
    });

    try {
      //get employee
      //insert into employee sqlite

      employeeList = [];

      final localDB = await _databaseHelper.database;

      setState(() {
        strLoading = "Updating Employees...";
      });

      var bytes =
          convert.utf8.encode('${settings.username}:${settings.password}');
      var base64Str = convert.base64.encode(bytes);

      var url = Uri.parse('${settings.apiurl}/api/employee');
      var header = {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Basic $base64Str",
      };

      var client = http.Client();
      var response = await client
          .get(url, headers: header)
          .timeout(const Duration(seconds: 30));
      var employees = employeesModelFromJson(response.body);

      setState(() {
        strLoading = "Clear Local Data";
      });

      await localDB!.delete('employee');

      for (final emp in employees) {
        //name format
        var strName = "";
        strName += emp.lastname.toString().toUpperCase();
        strName += ', ';
        strName += emp.firstname.toString().toUpperCase();
        if (emp.middlename.toString().trim() != '') {
          strName +=
              ' ${emp.middlename.toString().toUpperCase().substring(0, 1)}.';
        }

        setState(() {
          strLoading = strName;
        });

        emp.name = strName;
        emp.image = kNoImage;

        url = Uri.parse('${settings.apiurl}/api/employee/image');
        response = await client.post(url,
            body: convert.json.encode({'id': emp.id}), headers: header);
        var _images = empImageFromJson(response.body);
        for (final img in _images) {
          emp.image = img.image;
        }

        //sha256
        var keyEncode = convert.utf8.encode('minhs');
        var byteEncode = convert.utf8.encode(emp.id!);
        var hmacSha256 = Hmac(sha256, keyEncode); // HMAC-SHA256
        var hash = hmacSha256.convert(byteEncode);
        emp.hash = "$hash";

        //insert
        await localDB.rawInsert(
            'insert into employee (id, name, firstname, middlename, lastname, position, image, email, hash) values(?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [
              emp.id,
              emp.name,
              emp.firstname,
              emp.middlename,
              emp.lastname,
              emp.position,
              emp.image,
              emp.email,
              emp.hash
            ]);

        employeeList.add(emp);
      }

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kSuccessDialog(context, "Sync Complete"));
    } on Exception catch (e) {
      print('Exception');
      print(e.toString());

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    } catch (e) {
      print('e');
      print(e.toString());

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            'Employees',
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
                    strLoading == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              strLoading,
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
          'Employees',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync Employee',
            onPressed: () {
              syncData(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              syncData(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: employeeList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {},
                  title: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${employeeList[index].name}',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Employee No.: ${employeeList[index].id}',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Position: ${employeeList[index].position}',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Email: ${employeeList[index].email}',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Text(
                      //   'Hash: ${employeeList[index].hash}',
                      //   style: GoogleFonts.lato(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                  leading: ClipRRect(
                    child: Image.memory(convert.Base64Decoder()
                        .convert(employeeList[index].image!)),
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

  Widget showTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: TextFormField(
        controller: controller,
        onChanged: (text) => valueChanged(),
        maxLines: 1,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.lato(
            fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.lato(color: Colors.grey),
            hintStyle: GoogleFonts.lato(color: Colors.grey),
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: kPrimaryColor))),
      ),
    );
  }

  Widget showPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: TextFormField(
        controller: controller,
        onChanged: (text) => valueChanged(),
        maxLines: 1,
        obscureText: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.lato(
            fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.lato(color: Colors.grey),
            hintStyle: GoogleFonts.lato(color: Colors.grey),
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: kPrimaryColor))),
      ),
    );
  }

  void valueChanged() {
    setState(() {});
  }
}
