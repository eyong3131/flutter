import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Form imports
// ignore: unused_import
import './register.dart' as register;
import '../dashboard/dashboard.dart' as dashboard;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String _name;
  late String _email;
  String dropdownvalue = 'One';

  final inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //final PageController _pageController = PageController();

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

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    inputController.addListener(_printConsole);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    inputController.dispose();
    super.dispose();
  }

  void _printConsole() {
    // ignore: unused_local_variable
    returningData tawag = returningData();
    /*
    _name = inputController.text;
    tawag.setVal(_name);
    tawag.show();
    */
  }

  // ignore: non_constant_identifier_names
  Widget _TitleField() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      //color: Colors.lightBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset('assets/img/spc.png'),
          Container(
            width: _WidgetScale(false),
            height: _WidgetScale(false),
            child: Image.asset('assets/img/spc.png'),
          ),
          Text(
            'Login',
            style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                fontSize: _WidgetScale(true) * 0.40),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _NameField() {
    return TextFormField(
      //controller: inputController,
      decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
          hintText: "Enter your Name here!"),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return _name = "Please Enter Name";
        } else {
          _name = value;
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _EmailField() {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: "Enter your Email here!"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return _email = "Please Enter Email";
        } else {
          _email = value;
        }
        return null;
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _SignUp() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              fontSize: (20.0),
              color: Colors.blueAccent,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {})
      ]),
    );
  }

  // ignore: unused_element, non_constant_identifier_names
  Widget _DropDown() {
    return DropdownButton<String>(
      value: dropdownvalue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.deepOrange,
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newVal) {
        setState(() {
          dropdownvalue = newVal!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Practice Form",
            )),
            */
        body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /**
           * you can add multiple widgets under chilren here
           * This is the Container Part where we create a title for the forms
           */
            //_TitleField(),
            /**
           * this is the name field function where we called the input field
           * and other input fields
           */
            _TitleField(),
            Container(
              width: _WidgetScale(false) * 2.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NameField(),
                  _EmailField(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // opens the screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const dashboard.Dashboard()),
                        );
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("name is: $_name  \n email is: $_email"),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: _WidgetScale(true) * 0.40),
                    ),
                  ),
                  _SignUp(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// ignore: camel_case_types
class returningData {
  late String _iname;
  //late String _iemail;

  setVal(String? _name) {
    _iname = _name ?? "test";
    return _iname;
  }

  void show() {
    // ignore: avoid_print
    print('test conroller $_iname');
  }
}
