// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_is_empty

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhs/common/constantHelper.dart';
import 'package:minhs/common/databaseHelper.dart';
import 'package:minhs/common/sizeHelper.dart';
import 'package:minhs/pages/settings.dart';

class PinCode2Page extends StatefulWidget {
  const PinCode2Page({Key? key}) : super(key: key);

  @override
  _PinCode2PageState createState() => _PinCode2PageState();
}

class _PinCode2PageState extends State<PinCode2Page> {
  final databaseHelper = DatabaseHelper.instance;
  final formKey = GlobalKey<FormState>();

  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  TextEditingController pin3Controller = TextEditingController();
  TextEditingController pin4Controller = TextEditingController();

  var isLoading = false;
  var isError = false;
  var strError = "";
  var currentText = "";

  @override
  void initState() {
    super.initState();

    isLoading = false;
    isError = false;
    strError = "";

    pin1Controller.text = "";
    pin2Controller.text = "";
    pin3Controller.text = "";
    pin4Controller.text = "";

    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    isLoading = false;
    isError = false;
    strError = "";

    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();

    pin1Controller.clear();
    pin2Controller.clear();
    pin3Controller.clear();
    pin4Controller.clear();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  void handleTextFormField(String value, int index) {
    setState(() {
      isError = false;
      strError = "";
    });

    print('value : $value, index : $index');

    if (index == 1) {
      if (value.length > 1) {
        pin1Controller.text = value.substring(value.length - 1);
      }

      pin2FocusNode!.requestFocus();
    } else if (index == 2) {
      if (value.length > 1) {
        pin2Controller.text = value.substring(value.length - 1);
      }

      pin3FocusNode!.requestFocus();
    } else if (index == 3) {
      if (value.length > 1) {
        pin3Controller.text = value.substring(value.length - 1);
      }

      pin4FocusNode!.requestFocus();
    } else if (index == 4) {
      if (value.length > 1) {
        pin4Controller.text = value.substring(value.length - 1);
      }

      pin4FocusNode!.unfocus();
    }
  }

  void handleSubmit() async {
    print('handleSubmit : $currentText');

    if (pin1Controller.text == "") {
      pin1FocusNode!.unfocus();
      return;
    }

    if (pin2Controller.text == "") {
      pin2FocusNode!.unfocus();
      return;
    }

    if (pin3Controller.text == "") {
      pin3FocusNode!.unfocus();
      return;
    }

    if (pin4Controller.text == "") {
      pin4FocusNode!.unfocus();
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final localDB = await databaseHelper.database;
      var sql = "select pincode from login";
      var query = await localDB!.rawQuery(sql);

      print(sql);
      print('count : ${query.length}');

      var pin =
          '${pin1Controller.text}${pin2Controller.text}${pin3Controller.text}${pin4Controller.text}';

      if (query.length > 0) {
        sql = "update login set pincode = '" + pin + "'";
      } else {
        sql = "insert into login(pincode, username, password) values('" +
            pin +
            "', '', '')";
      }

      print(sql);
      var result = await localDB.rawQuery(sql);
      Get.off(SettingsPage());
      return;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper().init(context);

    // if (isError) {
    //   showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) =>
    //           localErrorDialog(context, strError));
    // }

    if (isLoading) {
      return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kPrimaryColor,
        //   centerTitle: true,
        //   title: Text(
        //     'Settings Pin',
        //     style: GoogleFonts.lato(
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            kLightColor,
            kPrimaryColor,
          ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.fill,
                        height: 140,
                        width: 140,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Set PIN",
                      style: GoogleFonts.lato(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: pin1Controller,
                              autofocus: true,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: otpInputDecoration,
                              onTap: () {
                                pin1Controller.clear();
                              },
                              onChanged: (value) {
                                handleTextFormField(value, 1);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: pin2Controller,
                              focusNode: pin2FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: otpInputDecoration,
                              onTap: () {
                                pin2Controller.clear();
                              },
                              onChanged: (value) {
                                handleTextFormField(value, 2);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: pin3Controller,
                              focusNode: pin3FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: otpInputDecoration,
                              onTap: () {
                                pin3Controller.clear();
                              },
                              onChanged: (value) {
                                handleTextFormField(value, 3);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: pin4Controller,
                              focusNode: pin4FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: otpInputDecoration,
                              onTap: () {
                                pin4Controller.clear();
                              },
                              onChanged: (value) {
                                handleTextFormField(value, 4);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => handleSubmit(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: kLightColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Save",
                              style: GoogleFonts.lato(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget localErrorDialog(context, message) {
    if (message.toString().length > 80) {
      message = message.toString().substring(0, 80);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 70, 10, 15),
              child: Column(
                children: [
                  Text(
                    'ERROR',
                    style: GoogleFonts.lato(
                      fontSize: 24.0,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    style: GoogleFonts.lato(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      onPressed: () => handleShowDialogOKClicked(context),
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
  }

  void handleShowDialogOKClicked(context) {
    print('handleShowDialogOKClicked');
    setState(() {
      isError = false;
      strError = "";
      Navigator.pop(context);
    });
  }
}
