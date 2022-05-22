import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ForgotWidget extends StatelessWidget {
  final String text;

  const ForgotWidget({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          width: 360,
          //L  //T    //R   //B
          padding: const EdgeInsets.fromLTRB(215.0, 5.0, 16.0, 4.0),
          child: Link(
            target: LinkTarget.self,
            uri: Uri.parse('https://flutter.dev'),
            builder: (context, followLink) => GestureDetector(
              onTap: followLink,
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ),
      );
}
