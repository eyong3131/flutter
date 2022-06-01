import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class window extends StatefulWidget {
  const window({ Key? key }) : super(key: key);

  @override
  State<window> createState() => _windowState();
}

var _screenWidth;
var _screenHeight;

//window dummy data:
List<String> _assigned = ["Ms. Cosaco"];
List<String> _program = ["EDUC"];
//purpose dummy data:
List<String> _pps = ["Enrollment Form", "Clearance", "Prospectus"];

//timelog dummy data:
List<String> _w1 = ["Mr. Neverbroke", "7:59AM", "5:03PM", "05-27-22"];
List<String> _w2 = ["Mr. Earlyseven", "7:55AM", "5:01PM", "05-27-22"];
List<String> _w3 = ["Ms. Smith", "8:00AM", "5:08PM", "05-27-22"];
List<String> _w4 = ["Mr. Macalintal", "7:51AM", "5:10PM", "05-27-22"];
List<String> _w5 = ["", "", "", ""];
List<String> _w6 = ["", "", "", ""];

class _windowState extends State<window> {
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 6),
              ButtonsTabBar(
                backgroundColor: Color.fromARGB(255, 14, 111, 141),
                contentPadding: EdgeInsets.symmetric(horizontal: 40),
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 37, 37, 37), fontFamily: "CGothic",),
                labelStyle:
                    const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "CGothic",
                    ),
                    height: 56,
                tabs: const [
                  Tab(
                    text: "WINDOWS",
                  ),
                  Tab(
                    text: "PURPOSE",
                  ),
                  Tab(
                    text: "TIME LOG",
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Divider(
                  color: Color.fromARGB(255, 58, 110, 153),
                  thickness: 3.0,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      child: _windows(_assigned, _program),
                    ),
                    Container(
                      child: _purpose(_pps),
                    ),
                    Container(
                      child: _timelog(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _windows(_assigned, _program) 
  {
    return SingleChildScrollView(
      primary: false,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 10,
            children: [
              Container(
                width: _screenWidth*0.25,
                height: _screenHeight*0.70,
                decoration: BoxDecoration(
                             color: Colors.white,
                             border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                             borderRadius: BorderRadius.circular(10),
                           ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 70,
                      child: Card(
                        color: Color.fromARGB(255, 47, 148, 179),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: ListTile(
                            title: Text(
                              "WINDOW",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: _screenHeight*0.50,
                        child: SingleChildScrollView(
                          primary: false,
                          child: ToggleSwitch(
                              isVertical: true,
                              fontSize: 20.0,
                              initialLabelIndex: 0,
                              activeBgColor: [Color.fromARGB(255, 47, 148, 179),],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.white,
                              inactiveFgColor: Color.fromARGB(255, 73, 73, 73),
                              dividerColor: Colors.grey,
                              minHeight: 60.0,
                              totalSwitches: 6,
                              labels: ['1', '2', '3', '4', '5', '6'],
                              onToggle: (index) {
                                //
                              },
                            ),
                        ),
                      ),
                    )
                  ],
                  )
              ),
    
              Container(
                width: _screenWidth*0.25,
                height: _screenHeight*0.70,
                decoration: BoxDecoration(
                             color: Colors.white,
                             border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                             borderRadius: BorderRadius.circular(10),
                           ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 70,
                      child: Card(
                        color: Color.fromARGB(255, 47, 148, 179),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: ListTile(
                            title: Text(
                              "ASSIGNED",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      height: _screenHeight*0.50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Table(
                                border: const TableBorder(
                                  horizontalInside: BorderSide(width: 1, color: Color.fromARGB(255, 145, 144, 144)),
                                  bottom: BorderSide(width: 1, color: Color.fromARGB(255, 145, 144, 144)),
                                ),
                                children: [
                                  for(var i=0; i<_assigned.length;i++)
                                  TableRow(
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(18),
                                          child: Text(_assigned[0], textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                                        ),  
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(17),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                    primary: Colors.lightBlue,
                                    onPrimary: Colors.grey, 
                                    minimumSize: Size.fromHeight(50),
                                    ),
                                    
                                    onPressed: () {
                                      _addUserAccount(context);
                                    },
                              
                                    child: const Text(
                                      "+ Add",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  )
              ),

              Container(
                width: _screenWidth*0.25,
                height: _screenHeight*0.70,
                decoration: BoxDecoration(
                             color: Colors.white,
                             border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                             borderRadius: BorderRadius.circular(10),
                           ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 70,
                      child: Card(
                        color: Color.fromARGB(255, 47, 148, 179),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: ListTile(
                            title: Text(
                              "PROGRAMS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      height: _screenHeight*0.50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            children: [
                              Table(
                              border: TableBorder.all(  
                              color: Color.fromARGB(255, 145, 144, 144),    
                              width: 2),  
                              children: [
                                for(var j=0; j<_program.length;j++)
                                TableRow(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.all(18),
                                        child: Text(_program[j], textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                                      ),  
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,10,0,0),
                                        child: IconButton(
                                          tooltip: "Edit",
                                          icon: const Icon(
                                            Icons.edit,
                                          ),
                                          color: Colors.blue,
                                          onPressed: () {},
                                        ),
                                      ),  
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,10,0,0),
                                        child: IconButton(
                                          tooltip: "Delete",
                                          icon: const Icon(
                                            Icons.delete,
                                          ),
                                          color: Colors.red,
                                          onPressed: () {},
                                        ),
                                      ),  
                                    ),
                                  ],
                                ),
                                
                              ],
                            ),
                            Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(17),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                        primary: Colors.lightBlue,
                                        onPrimary: Colors.grey, 
                                        minimumSize: Size.fromHeight(50),
                                        ),
                                        
                                        onPressed: () {
                                          _addProgram(context);
                                        },
                                  
                                        child: const Text(
                                          "+ Add",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          )
                        ),
                      ),
                    )
                  ],
                  )
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  bool _obscureText = true;
  final _user = TextEditingController();
  final _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _addUserAccount(BuildContext context) async {//Dialog box for adding new user account (WINDOW -> ASSIGNED -> ADD)
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: SingleChildScrollView(
            child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _user,
                  validator: (fld1) {
                    if (fld1 == null || fld1.isEmpty) {
                      return 'Please enter username.';
                    }
                      return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.account_circle_sharp),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _pass,
                  validator: (fld2) {
                    if (fld2 == null || fld2.isEmpty) {
                      return 'Please enter password.';
                    }
                      return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.key_rounded),
                    suffixIcon: GestureDetector(
                      onTap: (){
                      setState(() {
                        _obscureText=!_obscureText;
                      });
                      },
                      child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                    isDense: true,
                  ),
                ),
              ],
            ),
                  ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('ADD'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                    setState(() {
                      Navigator.pop(context);
                    });
                }
              },
            ),

          ],
        );
      });
}

  final _prog = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

  Future<void> _addProgram(BuildContext context) async {//Dialog box for adding new program (WINDOW -> PROGRAMS -> ADD)
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Program'),
          content: SingleChildScrollView(
            child: Form(
            key: _formKey2,
            child: Column(
              children: [
                TextFormField(
                  controller: _prog,
                  validator: (fld1) {
                    if (fld1 == null || fld1.isEmpty) {
                      return 'Please enter new Program.';
                    }
                      return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "New Program here",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    isDense: true,
                  ),
                ),
              ],
            ),
                  ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('ADD'),
              onPressed: () {
                if (_formKey2.currentState!.validate()) {
                    setState(() {
                      Navigator.pop(context);
                    });
                }
              },
            ),

          ],
        );
      });
}

  Widget _purpose(_pps)
  {
    return SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0,),
        child: Container(
          height: _screenHeight*0.70,
          decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 70,
                child: Card(
                  color: Color.fromARGB(255, 47, 148, 179),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: ListTile(
                      title: Text(
                        "TRANSACTION",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              Container(
                height: _screenHeight*0.50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      children: [
                        Table(
                        columnWidths: const {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        }, 
                        border: TableBorder.all(  
                        color: Color.fromARGB(255, 145, 144, 144),    
                        width: 2),  
                        children: [
                          for(var i=0; i<_pps.length;i++) 
                          TableRow(
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Text(_pps[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                                ),  
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                                  child: IconButton(
                                    tooltip: "Edit",
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {},
                                  ),
                                ),  
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0,10,0,0),
                                  child: IconButton(
                                    tooltip: "Delete",
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    color: Colors.red,
                                    onPressed: () {},
                                  ),
                                ),  
                              ),
                            ],
                          ),                
                        ],
                      ),
                      Container(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            onPrimary: Colors.grey, 
                            minimumSize: Size.fromHeight(50),
                            ),
                            
                            onPressed: () {
                              _addPurpose(context);
                            },
                      
                            child: const Text(
                              "+ Add",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ],
                    )
                  ),
                ),
              )
            ],
            ),
        ),
      ),
    );
  }
  final _prps = TextEditingController();
  final _formKey3 = GlobalKey<FormState>();

  Future<void> _addPurpose(BuildContext context) async {//Dialog box for adding new program (WINDOW -> PROGRAMS -> ADD)
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Program'),
          content: SingleChildScrollView(
            child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _prps,
                  validator: (fld1) {
                    if (fld1 == null || fld1.isEmpty) {
                      return 'Please enter new Purpose.';
                    }
                      return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "New Purpose here",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    isDense: true,
                  ),
                ),
              ],
            ),
                  ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('ADD'),
              onPressed: () {
                if (_formKey2.currentState!.validate()) {
                    setState(() {
                      Navigator.pop(context);
                    });
                }
              },
            ),

          ],
        );
      });
}

  Widget _timelog()
  {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 6),
              ButtonsTabBar(
                backgroundColor: Color.fromARGB(255, 14, 111, 141),
                contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 37, 37, 37), fontFamily: "CGothic",),
                labelStyle:
                    const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "CGothic",
                    ),
                    height: 56,
                tabs: const [
                  Tab(
                    text: "WINDOW 1",
                  ),
                  Tab(
                    text: "WINDOW 2",
                  ),
                  Tab(
                    text: "WINDOW 3",
                  ),
                  Tab(
                    text: "WINDOW 4",
                  ),
                  Tab(
                    text: "WINDOW 5",
                  ),
                  Tab(
                    text: "WINDOW 6",
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,),
                child: Divider(
                  color: Color.fromARGB(255, 58, 110, 153),
                  thickness: 3.0,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      child: _timelog_bywindow(_w1),
                    ),
                    Container(
                      child: _timelog_bywindow(_w2),
                    ),
                    Container(
                      child: _timelog_bywindow(_w3),
                    ),
                    Container(
                      child: _timelog_bywindow(_w4),
                    ),
                    Container(
                      child: _timelog_bywindow(_w5),
                    ),
                    Container(
                      child: _timelog_bywindow(_w6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timelog_bywindow(_window)
  {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, _screenHeight*.04),
      child: Container(
        decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color.fromARGB(255, 107, 107, 107), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            primary: false,
            child: Table(
              border: TableBorder.all(  
              color: Color.fromARGB(255, 145, 144, 144),    
              width: 2),  
              children: [
                TableRow(//header
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 47, 148, 179),
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Text('ACCOUNT/ASSIGNED', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white,)),
                      ),  
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 47, 148, 179),
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Text('LOGIN', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white,)),
                      ),  
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 47, 148, 179),
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Text('LOGOUT', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white,)),
                      ),  
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 47, 148, 179),
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18),
                        child: Text('DATE', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white,)),
                      ),  
                    ),
                  ],
                ),
                 
                TableRow(
                  children: [
                   for(var i=0; i<_window.length;i++) 
                   Container(
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Text(_window[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                      ),  
                    ),
                  ]
                )
          
                // TableRow(
                //   children: [
                //     Container(
                //       child: const Padding(
                //         padding: EdgeInsets.all(18),
                //         child: Text('Mr. Roldan Polintang', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                //       ),  
                //     ),
                //     Container(
                //       child: const Padding(
                //         padding: EdgeInsets.all(18),
                //         child: Text('7:59AM', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                //       ),  
                //     ),
                //     Container(
                //       child: const Padding(
                //         padding: EdgeInsets.all(18),
                //         child: Text('5:01PM', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                //       ),  
                //     ),
                //     Container(
                //       child: const Padding(
                //         padding: EdgeInsets.all(18),
                //         child: Text('05-26-22', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 73, 73, 73),)),
                //       ),  
                //     ),
                //   ],
                // ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}