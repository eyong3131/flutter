import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerController extends GetxController {
  var employeeID = "".obs;
  var employeeName = "".obs;
  var employeeImage = "".obs;
  var employeeStatus = "".obs;
  var employeePosition = "".obs;
  var interval = 0.obs;
  var timerStart = 0.0.obs;
  var timerID = "".obs;
  var hash = "".obs;

  var displayTimer = "".obs;
  var displayTimerStart = true.obs;
  var displayColor = Colors.white.obs;
  var loading = false.obs;

  var amIn = "".obs;
  var amOut = "".obs;
  var pmIn = "".obs;
  var pmOut = "".obs;

  void setHash(value) {
    hash.value = value;
  }

  void setEmployeeID(value) {
    employeeID.value = value;
  }

  void setEmployeePosition(value) {
    employeePosition.value = value;
  }

  void setEmployeeName(value) {
    employeeName.value = value;
  }

  void setEmployeeImage(value) {
    employeeImage.value = value;
  }

  void setEmployeeStatus(value) {
    employeeStatus.value = value;
  }

  void setTimerStart(value) {
    timerStart.value = value;
  }

  void setTimerID(value) {
    timerID.value = value;
  }

  void setInterval(value) {
    interval.value = value;
  }

  void setLoading(value) {
    loading.value = value;
  }

  void setDisplayTimer(value) {
    displayTimer.value = value;
  }

  void setDisplayTimerStart(value) {
    displayTimerStart.value = value;
  }

  void setDisplayColor(value) {
    if (value == 0) {
      displayColor.value = Colors.green;
    } else if (value == 1) {
      displayColor.value = Colors.red;
    } else if (value == 2) {
      displayColor.value = Colors.yellow;
    } else {
      displayColor.value = Colors.white;
    }
  }

  void setDtrRecord(strAMIn, strAMOut, strPMIn, strPM) {
    amIn.value = strAMIn;
    amOut.value = strAMOut;
    pmIn.value = strPMIn;
    pmOut.value = strPM;
  }
}
