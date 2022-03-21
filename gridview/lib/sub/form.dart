import 'package:flutter/material.dart';


class MyForm extends StatefulWidget {
  const MyForm({ Key? key }) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {

  Widget _NameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
        hintText: "Enter your Name here!"
        ),
      validator: (value){
        if(value == null || value.isEmpty){
          return "Please Enter Some Text";
        }
        return null;
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
          return "Please Enter Some Text";
        }
        return null;
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(centerTitle:true, title: Text("Practice Form",)),
      body: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _NameField(),
          _EmailField(),
          SizedBox(height: 100,),
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
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
      ));
  }
}