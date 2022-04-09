import 'package:flutter/material.dart';


class MyForm extends StatefulWidget {  
  const MyForm({ Key? key }) : super(key: key);
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {

  late String _name;
  late String _email;
  String dropdownvalue = 'One';


  final inputController = TextEditingController();

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

  void _printConsole(){
    // ignore: unused_local_variable
    returningData tawag = new returningData();
    /*
    _name = inputController.text;
    tawag.setVal(_name);
    tawag.show();
    */
  }
  
  Widget _TitleField(){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: Text(
        'PornHub',
        style: TextStyle(
          backgroundColor: Colors.black87,
          color: Colors.yellowAccent,
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),
      ),
    );
  }
  Widget _NameField(){
    return TextFormField(
      //controller: inputController,
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
        hintText: "Enter your Name here!"
        ),
      validator: (String? value){
        if(value == null || value.isEmpty){
          return _name  = "Please Enter Name";
        }else{
           _name = value;
        }
        return null;
      },
      onSaved: (String? value){
        _name = value!;
      },
    );
  }
  Widget _EmailField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your Email here!"
        ),
      validator: (value){
        if(value == null || value.isEmpty){
          return _email = "Please Enter Email";
        }else{
          _email = value;
        }
        return null;
      },
    );
  }
  // ignore: unused_element
  Widget _DropDown(){
    return DropdownButton<String>(
      value: dropdownvalue,
      icon:const Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(color: Colors.deepOrange,),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newVal){
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(centerTitle:true, title: Text("Practice Form",)),
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
          _TitleField(),
          /**
           * this is the name field function where we called the input field
           * and other input fields
           */
          _NameField(),
          //_DropDown(),
          _EmailField(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "name is: $_name  \n email is: $_email"),
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
      ), 
      ));
  }
}

class returningData {

  late String _iname;
  //late String _iemail;

  setVal(String? _name){
    _iname = _name ?? "test";
    return _iname;
  }
  void show(){
    print('test conroller $_iname');
  }
}