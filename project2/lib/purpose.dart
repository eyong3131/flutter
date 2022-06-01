import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:project2/qnumber.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

//json classes
import './classes/json/transaction.dart';
import './classes/json/programList.dart';

class Purpose extends StatefulWidget {
  const Purpose({Key? key}) : super(key: key);

  @override
  State<Purpose> createState() => _PurposeState();
}

class _PurposeState extends State<Purpose> {
  //json for list available
  //late List<Transaction> _json;
  late List<Transaction> _tmpjson;

  bool isLoaded = false;
  bool isSubmit = false;
  bool isProgItemsLoaded = false;

  //should be a list of program as json
  late List<ProgList> _progList;
  /*
  final List<String> progItems = [
    'BSIT',
    'BSBA',
    '...',
  ];
  */

  // list of purpose, should also be a json for flexibility
  final List<String> purposeItems = [
    'Enrollment',
    'Prospectus',
    'Clerance',
    '...',
  ];
  // selected strings in dropdown.
  // will be used to push in db transaction.
  // Pps is for puspose while the Prog is for degree or program.
  String? _fname;
  String? _mname;
  String? _lname;
  String? _selectedPps;
  String? _selectedProg;

  // checking for input statuses
  final _formKey = GlobalKey<FormState>();

  bool getDeviceType() {
    double ratio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    print(ratio);
    if ((ratio >= 0.45) && (ratio < 1.5) && (ratio >= 0.56) && (ratio < 1.77)) {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    //#2 calling in init the function
    // tried removing it here since i had setState function in loadData() and thought
    // it will be triggered but it did not
    // @Leo De Guzman
    _transactionProgramList();
  }

  // load data from remote or local database
  void _transactionProgramList() async {
    //#3 header
    var bytes = convert.utf8.encode('Transaction:Transaction');
    var base64Str = convert.base64.encode(bytes);
    // ignore: unused_local_variable
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //#4 body url
    var url = Uri.parse('http://127.0.0.1:3306/api/qwing/transactionProgList');
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
        //progListFromJson(response.body);
        _progList = progListFromJson(response.body);
        isProgItemsLoaded = true;
        //_json == null ? print("please wait") : print(_json[0].transactionName);
      });
    }
  }

  _tmpLoadData(String? name, String? middle, String? last, String? program,
      String? purpose) async {
    //#3 header
    var bytes = convert.utf8.encode('Transaction:Transaction');
    var base64Str = convert.base64.encode(bytes);
    // ignore: unused_local_variable
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //#4 body
    var body = convert.json.encode({
      'firstname': name,
      'middlename': middle,
      'lastname': last,
      'program': program,
      'purpose': purpose
    });

    //URL
    var url = Uri.parse('http://127.0.0.1:3306/api/qwing/transactionPull');
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
        _tmpjson = transactionFromJson(response.body);
        isLoaded = true;
        //_json == null ? print("please wait") : print(_json[0].transactionName);
      });
    }
  }

  //pass instruction on what should be done on carried data
  _passData(String? name, String? middle, String? last, String? program,
      String? purpose) async {
    //header
    var bytes = convert.utf8.encode('Transaction:Transaction');
    var base64Str = convert.base64.encode(bytes);
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Basic $base64Str",
    };
    //body and url
    var body = convert.json.encode({
      'firstname': name,
      'middlename': middle,
      'lastname': last,
      'program': program,
      'purpose': purpose
    });
    var url = Uri.parse('http://127.0.0.1:3306/api/qwing/transactionPush');
    var client = http.Client();
    var response = await client.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      print('success0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isProgItemsLoaded
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // constraints provide us with maxWidth,maxHeight etc, using
              // which we can show different widgets accordingly
              // @Gelang Code
              if (constraints.maxWidth <= 768) //mobile
              {
                return _pscreen1();
              } else //desktop
              {
                return _pscreen2();
              }
              // Checking the aspect ratio instead of calculating the specific
              // pixel width Since some smartphone has 4k resolution
              //  still need of some polishing in this code
              //  @Leo De Guzman
              /*
        if (getDeviceType()) {
          return _pscreen1();
        }
        return _pscreen2();
        */
            },
          )
        : spinkit;
  }

  final spinkit = SpinKitFadingFour(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  Widget _pscreen1() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Q-WING",
        ),
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          fontFamily: "CGothic",
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "FIRST NAME",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  //controller: _firstname,
                  validator: (fname) {
                    if (fname == null || fname.isEmpty) {
                      return 'Please enter your first name.';
                    } else {
                      _fname = fname;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "ENTER YOUR FIRST NAME",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "MIDDLE NAME",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  //controller: _middlename,
                  validator: (mname) {
                    if (mname == null || mname.isEmpty) {
                      return 'Please enter your middle name.';
                    } else {
                      _mname = mname;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "ENTER YOUR MIDDLE NAME",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "LAST NAME",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  //controller: _lastname,
                  validator: (lname) {
                    if (lname == null || lname.isEmpty) {
                      return 'Please enter your last name.';
                    } else {
                      _lname = lname;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "ENTER YOUR LAST NAME",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "PROGRAM",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'SELECT YOUR PROGRAM',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    items: _progList
                        .map((item) => DropdownMenuItem<String>(
                              value: item.programAcronym!.toString(),
                              child: Text(
                                item.programAcronym!.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (program) {
                      if (program == null) {
                        return 'Please select your program.';
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (prog) {
                      _selectedProg = prog.toString();
                    },
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "PURPOSE",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "CGothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'SELECT YOUR PURPOSE',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    items: purposeItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (purpose) {
                      if (purpose == null) {
                        return 'Please select your purpose.';
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (pps) {
                      _selectedPps = pps.toString();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 27, 119, 57),
                    onPrimary: Colors.grey,
                    minimumSize: Size.fromHeight(70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isSubmit
                      ? null
                      : () {
                          isSubmit = true;
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _passData(_fname, _mname, _lname, _selectedProg,
                                _selectedPps);
                            //this is not practical but it is working for now
                            Timer(Duration(seconds: 2), () {
                              _tmpLoadData(_fname, _mname, _lname,
                                  _selectedProg, _selectedPps);
                            });
                            //due to either slow internet or bad code, I had to
                            //slow down execution time so the _tmojson can load in time
                            Timer(Duration(seconds: 3), () {
                              var lastIndex = _tmpjson.length;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // do add an incremental value to the selected list
                                        QueueNum(
                                            qnum: _selectedProg! +
                                                ' - ' +
                                                _tmpjson[lastIndex - 1]
                                                    .transactionId
                                                    .toString())),
                              );
                            });
                          }
                        },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "GENERATE TRANSACTION NUMBER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pscreen2() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Q-WING",
        ),
        titleTextStyle: const TextStyle(
          fontSize: 60,
          fontFamily: "CGothic",
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        toolbarHeight: 100,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Row(children: [
                Container(
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "FIRST NAME",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "CGothic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            //controller: _firstname,

                            validator: (fname) {
                              if (fname == null || fname.isEmpty) {
                                return 'Please enter your first name.';
                              } else {
                                _fname = fname;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "ENTER YOUR FIRST NAME",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "MIDDLE NAME",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "CGothic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            //controller: _middlename,
                            validator: (mname) {
                              if (mname == null || mname.isEmpty) {
                                return 'Please enter your middle name.';
                              } else {
                                _mname = mname;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "ENTER YOUR MIDDLE NAME",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "LAST NAME",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "CGothic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            //controller: _lastname,
                            validator: (lname) {
                              if (lname == null || lname.isEmpty) {
                                return 'Please enter your last name.';
                              } else {
                                _lname = lname;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "ENTER YOUR LAST NAME",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "MAY 01,2022",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "CGothic",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            "11:03 AM",
                            style: TextStyle(
                              fontSize: 70,
                              fontFamily: "CGothic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Expanded(
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "PROGRAM",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "CGothic",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'SELECT YOUR PROGRAM',
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            items: _progList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.programAcronym!.toString(),
                                      child: Text(
                                        item.programAcronym!.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (program) {
                              if (program == null) {
                                return 'Please select your program.';
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (prog) {
                              _selectedProg = prog.toString();
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "PURPOSE",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "CGothic",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'SELECT YOUR PURPOSE',
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            items: purposeItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (purpose) {
                              if (purpose == null) {
                                return 'Please select your purpose.';
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                            },
                            onSaved: (pps) {
                              _selectedPps = pps.toString();
                            },
                          ),
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 27, 119, 57),
                            onPrimary: Colors.grey,
                            minimumSize: Size.fromHeight(220),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: isSubmit
                              ? null
                              : () {
                                  isSubmit = true;
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _passData(_fname, _mname, _lname,
                                        _selectedProg, _selectedPps);
                                    //this is not practical but it is working for now
                                    Timer(Duration(seconds: 2), () {
                                      _tmpLoadData(_fname, _mname, _lname,
                                          _selectedProg, _selectedPps);
                                    });
                                    //due to either slow internet or bad code, I had to
                                    //slow down execution time so the _tmojson can load in time
                                    Timer(Duration(seconds: 3), () {
                                      var lastIndex = _tmpjson.length;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                // do add an incremental value to the selected list
                                                QueueNum(
                                                    qnum: _selectedProg! +
                                                        ' - ' +
                                                        _tmpjson[lastIndex - 1]
                                                            .transactionId
                                                            .toString())),
                                      );
                                    });
                                  }
                                },
                          child: const Text(
                            "GENERATE\nTRANSACTION\nNUMBER",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "CGothic",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
