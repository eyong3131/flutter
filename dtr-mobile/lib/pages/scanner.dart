// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:minhs/common/constantHelper.dart';
import 'package:minhs/common/databaseHelper.dart';
import 'package:minhs/controller/scannerController.dart';
import 'package:minhs/model/settingsModel.dart';
import 'package:minhs/pages/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage>
    with TickerProviderStateMixin {
  final databaseHelper = DatabaseHelper.instance;
  var controller = Get.put(ScannerController());

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  Barcode? barcode;
  QRViewController? qrViewController;
  SettingsModel settings = SettingsModel();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool onScannedProcess = false;
  bool isLoading = false;
  String timeDisplay = "";

  Timer? timer1;
  Timer? timer2;

  final _flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }

    Timer.periodic(Duration(seconds: 5), (Timer t) => _handleTimerReset());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _handleTimerDisplay());

    initializeTts();
    loadData();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController?.pauseCamera();
    }

    qrViewController?.resumeCamera();
  }

  @override
  void dispose() {
    print('scanner disposed');
    qrViewController?.dispose();
    timer1?.cancel();
    timer2?.cancel();

    onScannedProcess = false;
    isLoading = false;
    _flutterTts.stop();

    super.dispose();
  }

  void initializeTts() async {
    // print('initializeTts');
    // var lng = await _flutterTts.getLanguages;
    // var voc = await _flutterTts.getVoices;

    //fil-PH
    // await _flutterTts.setLanguage("fil-PH");
    // await _flutterTts.setVoice("fil-PH");

    // for (final item in lng) {
    //   print(item);
    // }

    // for (final item in voc) {
    //   print(item);
    // }

    // await _flutterTts.setLanguage("en-US");
    // await _flutterTts.setSpeechRate(1.0);
    // await _flutterTts.setPitch(1.0);

    _flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });

    speak("WELCOME");
  }

  void speak(text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  void stop() async {
    await _flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    controller.setTimerStart(
        double.parse(DateFormat("yyyyMMddHHmmss").format(DateTime.now())));
    controller.setDisplayColor(99);
    controller.setDisplayTimer("");

    await loadSettings();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadSettings() async {
    try {
      final localDB = await databaseHelper.database;

      //get settings
      var query = await localDB!.rawQuery('select * from settings');

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
            "MINHS",
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
        drawer: MenuPage(),
        backgroundColor: kLightColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "MINHS",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera),
              tooltip: 'Flip Camera',
              onPressed: () {
                qrViewController?.flipCamera();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                controller.setHash("");
                controller.setTimerID("");
                controller.setEmployeeID("");
                controller.setEmployeeName("");
                controller.setEmployeeImage("");
                controller.setEmployeeStatus("");
                controller.setDisplayColor(99);
                controller.setDisplayTimer("");
                controller.setDtrRecord("", "", "", "");

                if (Platform.isAndroid) {
                  qrViewController?.pauseCamera();
                }

                qrViewController?.resumeCamera();
                onScannedProcess = false;
                setState(() {});
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: _buildQrView(context),
            ),
            Expanded(
              flex: 3,
              child: onScannedProcess
                  ? SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            child: _displayImage(),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              controller.employeeName.value == ""
                                  ? "SCAN EMPLOYEE QR"
                                  : controller.employeeName.value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.employeeID.value == ""
                                  ? Container()
                                  : Text(
                                      "Employee No. : " +
                                          controller.employeeID.value,
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      )),
                              controller.employeeID.value == ""
                                  ? Container()
                                  : Text(
                                      "Position : " +
                                          controller.employeePosition.value,
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      )),
                            ],
                          ),
                          Center(
                            child: Text(controller.displayTimer.value,
                                style: GoogleFonts.lato(
                                  fontSize: 56,
                                  color: controller.displayColor.value,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          displayRecord()
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayRecord() {
    if (controller.amIn.value == "" &&
        controller.amOut.value == "" &&
        controller.pmIn.value == "" &&
        controller.pmOut.value == "") {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("AM IN",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Text(controller.amIn.value,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text("AM OUT",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    )),
                Text(controller.amOut.value,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text("PM IN",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Text(controller.pmIn.value,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text("PM OUT",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    )),
                Text(controller.pmOut.value,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _displayImage() {
    if (controller.employeeImage.value != "") {
      return Image.memory(
        convert.Base64Decoder().convert(controller.employeeImage.value),
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      );
    } else {
      return Image.asset(
        "assets/images/logo.png",
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // print('width : ${MediaQuery.of(context).size.width}');
    // print('height : ${MediaQuery.of(context).size.height}');

    var scanArea = 0.0;
    //var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    scanArea = (height / 2) * 0.80;
    //print('scan area : $scanArea');

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: onScannedProcess ? Colors.greenAccent : Colors.white,
          borderRadius: 10,
          borderLength: 15,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController qrvController) {
    setState(() {
      qrViewController = qrvController;
    });

    qrvController.scannedDataStream.listen((scanData) {
      print('${scanData.code} != ${controller.hash.value}');

      if (scanData.code != controller.hash.value) {
        controller.setHash(scanData.code);
        controller.setTimerID(scanData.code);

        setState(() {
          onScannedProcess = true;
        });

        handleProcess(scanData.code);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _handleTimerReset() {
    var timerStop =
        double.parse(DateFormat("yyyyMMddHHmmss").format(DateTime.now()));
    var timerDiff = timerStop - controller.timerStart.value;
    if (timerDiff > 15) {
      print(
          '${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())} : _handleTimer event');
      controller.setTimerStart(timerStop);
      controller.setEmployeeID("");
      controller.setHash("");
      controller.setEmployeeName("");
      controller.setEmployeeImage("");
      controller.setEmployeeStatus("");
      controller.setDisplayTimerStart(true);
      controller.setDisplayColor(99);
      controller.setDtrRecord("", "", "", "");

      if (!mounted) return;
      setState(() {});
    }
  }

  void _handleTimerDisplay() {
    if (controller.displayTimerStart.value) {
      controller.setDisplayTimer(DateFormat("hh:mm a").format(DateTime.now()));
      controller.setDtrRecord("", "", "", "");

      if (!mounted) return;
      setState(() {});
    }
  }

  Future sendToServer(id, date, time) async {
    try {
      final localDB = await databaseHelper.database;

      var bytes =
          convert.utf8.encode('${settings.username}:${settings.password}');
      var base64Str = convert.base64.encode(bytes);
      var header = {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Basic $base64Str",
      };

      var body = convert.json.encode({'id': id, 'date': date, 'time': time});
      var url = Uri.parse('${settings.apiurl}/api/dtr');
      var client = http.Client();
      var response = await client.post(url, body: body, headers: header);

      if (response.statusCode == 200) {
        //update empdtr
        await localDB!.rawInsert(
            'update empdtr set status = 1 where id = ? and date = ? and time = ?',
            [id, date, time]);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void handleProcess(code) async {
    try {
      final localDB = await databaseHelper.database;

      var _id = "";
      var _firstname = "";
      var _curdate = DateTime.now();
      var _date = DateFormat("yyyy-MM-dd").format(_curdate).toUpperCase();
      var _time = DateFormat("hh:mm a").format(_curdate).toUpperCase();

      //get employee
      var query = await localDB!.rawQuery(
          "select id, name, firstname, image, position from employee where id = '$code'");

      //clear name
      controller.setEmployeeName("");
      controller.setEmployeeStatus("");
      controller.setDisplayTimerStart(false);
      controller.setDisplayTimer("");
      controller.setDisplayColor(99);

      for (final item in query) {
        controller.setEmployeeID('${item["id"]}');
        controller.setEmployeeName('${item["name"]}');
        controller.setEmployeeImage('${item["image"]}');
        controller.setEmployeePosition('${item["position"]}');
        controller.setTimerStart(
            double.parse(DateFormat("yyyyMMddHHmmss").format(DateTime.now())));

        _id = '${item["id"]}';
        _firstname = '${item["firstname"]}';
      }

      if (controller.employeeName.value == "") {
        controller.setEmployeeImage("");
        controller.setEmployeeName("RECORD NOT FOUND");
        audioCache.play('sounds/error.mp3');
      } else {
        //check if exist then ignore
        query = await localDB.rawQuery(
            "select id from empdtr where id = '$_id' and date = '$_date' and time = '$_time'");

        if (query.isNotEmpty) {
          controller.setEmployeeName("");
          controller.setEmployeeStatus("");
          controller.setDisplayTimerStart(false);
          controller.setDisplayTimer("");
          controller.setDisplayColor(99);
          audioCache.play('sounds/error.mp3');
        } else {
          //insert and send to cloud
          if (_firstname != "") {
            audioCache.play('sounds/success.mp3');
            speak("WELCOME " + _firstname.toUpperCase());
          } else {
            audioCache.play('sounds/success.mp3');
          }

          await localDB.rawInsert(
              'insert into empdtr (id, date, time, status) values(?, ?, ?, ?)',
              [_id, _date, _time, 0]);

          controller.setDisplayTimer(_time);
          controller.setDisplayColor(0);

          //send to server
          sendToServer(_id, _date, _time);
        }
      }

      //insert DTR
      setState(() {
        onScannedProcess = false;
      });
    } on SocketException catch (e) {
      setState(() {
        controller.setEmployeeName("CONNECTION ERROR");
        controller.setEmployeeID("");
        controller.setHash("");
        controller.setEmployeeImage("");
        controller.setDisplayTimer("");
        controller.setDisplayColor(0);
        controller.setDtrRecord("", "", "", "");
        onScannedProcess = false;
      });

      audioCache.play('sounds/error.mp3');
    } on Exception catch (e) {
      audioCache.play('sounds/error.mp3');
      controller.setEmployeeImage("");
      controller.setEmployeeID("");
      controller.setHash("");
      controller.setEmployeeName("");
      controller.setDisplayTimer("");
      controller.setDisplayColor(0);
      controller.setDtrRecord("", "", "", "");

      setState(() {
        onScannedProcess = false;
      });

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    } catch (e) {
      audioCache.play('sounds/error.mp3');
      controller.setEmployeeImage("");
      controller.setEmployeeID("");
      controller.setHash("");
      controller.setEmployeeName("");
      controller.setDisplayTimer("");
      controller.setDisplayColor(0);
      controller.setDtrRecord("", "", "", "");

      setState(() {
        onScannedProcess = false;
      });

      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              kErrorDialog(context, e.toString()));
    }
  }
}
