import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
//import 'package:package:project3/modules/login/pages/home_page.dart';
//import 'package:package:project3/modules/login/widgets/loginbutton_widget.dart';

import '../widgets/dropdown_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/forgot_widget.dart';
import '../widgets/signup_widget.dart';
import 'package:http/http.dart' as http;

//password decrypt test
// @Leo De Guzman
import '../password/decrypt.dart';
import '../json/hash.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String? _name;
  String? _password;

  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

  late List<Generator> json;
  late String hashed;
  late String username;

  //i moved this widget to top or can be also moved to other file so the column
  //can be a little bit cleaner
  Widget userField() => Center(
        child: Container(
          width: 360,
          height: 50,
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: TextFormField(
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5, color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue.shade100,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Colors.red.shade200),
              ),
              hintText: 'Enter username',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return _name = "Name";
              } else {
                _name = value;
              }
              return null;
            },
            onSaved: (String? value) {
              _name = value!;
            },
          ),
        ),
      );
  // this is the password textfield
  Widget passwordField() => Container(
        width: 360,
        height: 35,
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 16),
          obscureText: _isHidden,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            hintText: 'Password',
            suffix: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                _isHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue.shade100,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Colors.red.shade200),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return _password = "password is needed";
            } else {
              _password = value;
            }
            return null;
          },
          onSaved: (String? value) {
            _password = value!;
          },
        ),
      );

  @override
  void initState() {
    super.initState();
    //#2 calling in init the function
    // tried removing it here since i had setState function in loadData() and thought
    // it will be triggered but it did not
    // @Leo De Guzman
    _loadData();
  }

  // _loadData loads the database from api
  // @Leo De Guzman
  void _loadData() async {
    //#3 header
    var bytes = convert.utf8.encode('hashed:hashed');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //#4 body url
    // ip needs to be changed on every dev device
    var url = Uri.parse('http://192.168.1.15:3306/api/hash_test');
    var client = http.Client();
    var response = await client.post(url);
    if (response.statusCode == 200) {
      //#5 tried also removing the setState here but it is not
      // loading the json so i had to bring it back here
      // The  " ! " in the variable is a null checker and it is
      // needed on a variable that does not accept null e.g String? or int?.
      // that json.index needs more of refactoring in the other stages
      // eg username or email
      setState(() {
        json = generatorFromJson(response.body);
        hashed = json[4].hash!;
        username = json[4].username!;
        //_isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 400,
                  height: 480,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const HeaderWidget(
                        title: 'Login Form',
                      ),
                      Container(
                        width: 330,
                        //L  //T    //R   //B
                        padding: const EdgeInsets.fromLTRB(0, 20.0, 16.0, 5.0),
                        child: const Text(
                          'Window',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      DropdownWidget(),
                      //Username
                      Container(
                        width: 330,
                        //L  //T    //R   //B
                        padding: const EdgeInsets.fromLTRB(0, 30.0, 16.0, 4.0),
                        child: const Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Username TextField
                      userField(),
                      //Password
                      Container(
                        width: 330,
                        //L  //T    //R   //B
                        padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 4.0),
                        child: const Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Password Field
                      passwordField(),
                      //forgot
                      const ForgotWidget(text: 'Forgot password?'),
                      //Login Button
                      Container(
                        //L  //T    //R   //B
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 0, 140, 255),
                                  width: 4),
                            ),
                            primary: Colors.lightBlue,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //Decrypt(_password!, hashed, _name!, username);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(Decrypt(_password!, hashed,
                                              _name!, username)
                                          .check)));
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Signup
                      const SignupWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
