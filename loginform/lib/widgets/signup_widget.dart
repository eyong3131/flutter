import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          width: 360,
          //L  //T    //R   //B
          padding: const EdgeInsets.fromLTRB(50.0, 10.0, 16.0, 4.0),
          child: Link(
            target: LinkTarget.self,
            uri: Uri.parse('https://flutter.dev'),
            builder: (context, followLink) => GestureDetector(
              onTap: followLink,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "You don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
