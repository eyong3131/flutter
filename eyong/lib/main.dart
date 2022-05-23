import 'package:flutter/material.dart';
import './login/login_form.dart' as login;
import '../dashboard/dashboard.dart' as dashboard;

void main() {
  runApp(const MaterialApp(
    home: login.Login(), //dashboard.Dashboard(),
  ));
}
