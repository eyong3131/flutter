import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
    required Null Function() onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
                color: Color.fromARGB(255, 0, 140, 255), width: 4),
          ),
          primary: Colors.lightBlue,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
}

/*Container(
                        width: 360,
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 4.0),
                        child: ButtonWidget(
                          text: 'Login',
                          onClicked: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomepageWidget()),
                          ),
                          onPressed: () {
                            login();
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                        ),
                      ),*/