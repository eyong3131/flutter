import 'package:flutter/material.dart';
import 'package:project3/modules/login/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Form',
        theme: ThemeData(primaryColor: Colors.blue),
        home: const Loginpage(),
      );
}
