import 'package:flutter/material.dart';
import './sub_modules/code_generator.dart';
import './sub_modules/hash.dart';
import './sub_modules/decrypt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// note the loadData function is not needed in this module but
// only used for testing for future reference.
class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);
  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  //#1 Dropdown variable
  List<String> items = ['BSIT', 'Other'];
  String? selected = 'BSIT';
  //#1.1 input Variable
  String? _name;
  late String _middle;
  late String _lastname;
  late String _que;
  // ignore: non_constant_identifier_names
  late String QNumber;
  //#1.2 form key for input form
  final _formKey = GlobalKey<FormState>();

  //#1.3 json variable
  late List<Generator> json;
  late String hashed;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    //#2 calling in init the function
    // tried removing it here since i had setState function in loadData() and thought
    // it will be triggered but it did not
    _loadData();
  }

  void _loadData() async {
    //#3 header
    var bytes = convert.utf8.encode('viral:viral');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //#4 body url
    var url = Uri.parse('http://192.168.1.3:3306/api/hash_test');
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
        _isloading = false;
      });
    }
  }

  //#6 always dispose the eventlistener if its not needed anymore
  @override
  void dispose() {
    super.dispose();
  }

  //#6 Widget Scale for universal scalling
  // ignore: non_constant_identifier_names
  _WidgetScale(bool isText) {
    double? scale;
    if (isText) {
      //still dont know how to properly implement this screens
      if (MediaQuery.of(context).size.height >= 720 ||
          MediaQuery.of(context).size.height <= 1024) {
        scale = MediaQuery.of(context).size.height * 0.10;
      }
    } else {
      if (MediaQuery.of(context).size.height >= 720 ||
          MediaQuery.of(context).size.height <= 1024) {
        scale = MediaQuery.of(context).size.height * 0.20;
      }
    }
    return scale;
  }

  //#7 Text Scalling for body text
  // ignore: non_constant_identifier_names
  _TextFormScale(bool textforms) {
    double? scale;
    if (textforms) {
      scale = MediaQuery.of(context).size.height * 0.05;
    } else {
      scale = MediaQuery.of(context).size.height * 0.10;
    }
    return scale;
  }

  //#8 Name field for entering the data
  // ignore: non_constant_identifier_names
  Widget _First_name() => TextFormField(
        //decorating the input field
        //this is the same for all input field
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: "Middle Name",
        ),
        //Font size scale the size of the input field
        style: TextStyle(fontSize: _TextFormScale(true) * 0.60),
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
      );

  // ignore: non_constant_identifier_names
  //#9 Middle name
  // ignore: non_constant_identifier_names
  Widget _Middle_Name() => TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: "Middle Name"),
        style: TextStyle(fontSize: _TextFormScale(true) * 0.60),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return _middle = "Middle Name";
          } else {
            _middle = value;
          }
          return null;
        },
        onSaved: (String? value) {
          _middle = value!;
        },
      );
  // ignore: non_constant_identifier_names
  Widget _Last_Name() => TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: "Last Name"),
        style: TextStyle(fontSize: _TextFormScale(true) * 0.60),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return _lastname = "Last Name";
          } else {
            _lastname = value;
          }
          return null;
        },
        onSaved: (String? value) {
          _lastname = value!;
        },
      );
  // ignore: non_constant_identifier_names
  //#10 Dropdown for the program
  // ignore: non_constant_identifier_names
  Widget _Program() => DropdownButtonFormField<String>(
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        //#10.1 isDense disable something that let the text style properties resize
        // the input box or item menu list or dropdownmenuitem<String>.
        //#10.2 itemHeight might come in the handy in the future so I didnt remove it yet
        // it let you set minimum height for list so it could be scrollable
        isDense: false,
        //itemHeight: _WidgetScale(false) * 0.60,
        value: selected,
        //#10.3 .map is like a loop that looks for all the items in the array
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: _TextFormScale(true) * 0.60),
                  ),
                ))
            .toList(),
        //#10.4 setting the state of selected item if its changed before submit
        onChanged: (item) => setState(() => selected = item),
      );
  // ignore: non_constant_identifier_names
  // the same as the first names and other input fields
  // ignore: non_constant_identifier_names
  Widget _QNumber() => TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: "e.g BSIT - 0001"),
        style: TextStyle(fontSize: _TextFormScale(true) * 0.60),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return _que = "Queue #";
          } else {
            _que = value;
          }
          return null;
        },
        onSaved: (String? value) {
          _que = value!;
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Q - wing",
              style: TextStyle(
                fontSize: _WidgetScale(true) * 0.60,
              )),
          toolbarHeight: _WidgetScale(false) * 0.60,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 60.0, right: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //First row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _WidgetScale(true) * 0.35),
                    ),
                    _First_name(),
                  ],
                ),
                //Second Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Middle Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _WidgetScale(true) * 0.35),
                    ),
                    _Middle_Name(),
                  ],
                ),
                //Third Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Last Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _WidgetScale(true) * 0.35),
                    ),
                    _Last_Name(),
                  ],
                ),
                // fourth Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Program',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _WidgetScale(true) * 0.35),
                    ),
                    _Program(),
                  ],
                ),
                //Fifth Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Queue Number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _WidgetScale(true) * 0.35),
                    ),
                    _QNumber(),
                  ],
                ),
                // Sixth Row
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(_WidgetScale(true) * 0.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    //#11 Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      //testing for password hash
                      //Password(_name!);

                      _isloading
                          ? print("Json is still loading")
                          : Decrypt(_name!, hashed);

                      //#12 If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      /*
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "name is: $_name  \n middle is: $_middle  \n Last Name is: $_lastname  \n Que Number is is: $_que  \n Program is: $selected",
                            style: TextStyle(fontSize: _TextFormScale(true)),
                          ),
                        ),
                      );
                      */
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: _WidgetScale(true) * 0.60),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
