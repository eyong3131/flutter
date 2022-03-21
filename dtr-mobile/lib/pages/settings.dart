// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhs/common/constantHelper.dart';
import 'package:minhs/common/databaseHelper.dart';
import 'package:minhs/model/settingsModel.dart';
import 'package:minhs/pages/menu.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final databaseHelper = DatabaseHelper.instance;

  TextEditingController txtSite = TextEditingController();
  TextEditingController txtInterval = TextEditingController();
  TextEditingController txtApiUrl = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool errSite = false;
  bool errInterval = false;
  bool errApiUrl = false;
  bool errUsername = false;
  bool errPassword = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    errSite = false;
    errInterval = false;
    errApiUrl = false;
    errUsername = false;
    errPassword = false;
    isLoading = false;
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      print('loadData');

      final localDB = await databaseHelper.database;
      var results = await localDB!.rawQuery('select * from settings');

      txtSite.text = "admin";
      txtInterval.text = "10";
      txtApiUrl.text = "http://localhost:9001";
      txtUsername.text = "dtr";
      txtPassword.text = "dtr";

      if (results.isEmpty) {
      } else {
        print("settings with record");
        var settings = SettingsModel.fromJson(results.first);
        txtSite.text = settings.site!;
        txtInterval.text = settings.interval!;
        txtApiUrl.text = settings.apiurl!;
        txtUsername.text = settings.username!;
        txtPassword.text = settings.password!;
      }
    } on Exception catch (e) {
      // showDialog<String>(
      //     context: context,
      //     builder: (BuildContext context) =>
      //         kErrorDialog(context, e.toString()));
    } catch (e) {
      // showDialog<String>(
      //     context: context,
      //     builder: (BuildContext context) =>
      //         kErrorDialog(context, e.toString()));
    }

    setState(() {
      isLoading = false;
    });
  }

  void valueChanged() {
    setState(() {
      errSite = false;
      errInterval = false;
      errApiUrl = false;
      errUsername = false;
      errPassword = false;
    });
  }

  void handleSaveSettings() async {
    setState(() {
      isLoading = true;
    });

    try {
      final localDB = await databaseHelper.database;

      await localDB!.rawDelete("delete from settings");
      await localDB.rawInsert(
          'insert into settings (site, interval, apiurl, username, password) values(?, ?, ?, ?, ?)',
          [
            txtSite.text,
            txtInterval.text,
            txtApiUrl.text,
            txtUsername.text,
            txtPassword.text
          ]);

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kSuccessDialog(context, "Settings Updated"));
    } on Exception catch (e) {
      print(e.toString());

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    } catch (e) {
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
            'Settings',
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
          'Settings',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.save),
        //     tooltip: 'Save Settings',
        //     onPressed: () {
        //       handleSaveSettings();
        //     },
        //   ),
        // ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: kPrimaryColor,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.monitor),
      //       label: 'Site',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.storage),
      //       label: 'Connection',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.login),
      //       label: 'Log Type',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   unselectedItemColor: Colors.white,
      //   unselectedLabelStyle: GoogleFonts.lato(
      //     fontWeight: FontWeight.w700,
      //   ),
      //   selectedLabelStyle: GoogleFonts.lato(
      //     fontWeight: FontWeight.w700,
      //   ),
      //   onTap: _onItemTapped,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Terminal ',
                    style: GoogleFonts.lato(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              showTextField('Site Code', txtSite),
              showNumberField('Process Interval', txtInterval),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Connection',
                    style: GoogleFonts.lato(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              showTextField('Node', txtApiUrl),
              showTextField('Username', txtUsername),
              showPasswordField('Password', txtPassword),
              SizedBox(
                height: 10.0,
              ),
              showSaveButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget showSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            // width: 150,
            height: 50,
            child: ElevatedButton(
              child: Text(
                "Save Settings",
                style: GoogleFonts.lato(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(kLightColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () => handleSaveSettings(),
            ),
          ),
        ],
      ),
    );
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

  Widget showNumberField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: TextFormField(
        controller: controller,
        onChanged: (text) => valueChanged(),
        maxLines: 1,
        keyboardType: TextInputType.number,
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
}
