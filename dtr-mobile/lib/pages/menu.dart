// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhs/common/databaseHelper.dart';
import 'package:minhs/pages/employees.dart';
import 'package:minhs/pages/login.dart';
import 'package:minhs/pages/pincode.dart';
import 'package:minhs/pages/pincode2.dart';
import 'package:minhs/pages/scanner.dart';
import 'package:minhs/pages/settings.dart';
import 'package:minhs/pages/logs.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final databaseHelper = DatabaseHelper.instance;

  void handleSettingsClicked() async {
    try {
      final localDB = await databaseHelper.database;
      var query = await localDB!.rawQuery("select pincode from login");

      print('handleSettingsClicked');
      print('count : ${query.length}');
      print(query);
      print('handleSettingsClicked 2');

      if (query.isNotEmpty) {
        print(query[0]["pincode"]);

        if (query[0]["pincode"] != "") {
          Get.to(PinCodePage());
        } else {
          Get.off(SettingsPage());
        }
      } else {
        Get.to(PinCode2Page());
      }

      // var cnt = int.parse(query[0]["cnt"].toString());
      // if (cnt > 0) {
      //   Get.to(SettingsPage());
      // } else {
      //   isError = true;
      //   strError = "Invalid Pin";
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff021A3C),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 10.0),
                    Text('MINHS',
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    Text('Daily Time Record',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: Text('QR Code',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => Get.off(ScannerPage()),
            ),
            ListTile(
              leading: const Icon(Icons.table_view),
              title: Text('Logs',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => Get.off(LogsPage()),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: Text('Employees',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => Get.off(EmployeesPage()),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Settings',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => handleSettingsClicked(),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text('Exit',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                  )),
              onTap: () => exit(0),
            ),
          ],
        ),
      ),
    );
  }
}
