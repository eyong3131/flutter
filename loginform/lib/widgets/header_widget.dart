import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Center(
          child: Container(
            width: 400,
            height: 60,
            decoration: const BoxDecoration(color: Colors.blue),
            padding: const EdgeInsets.fromLTRB(130.0, 10, 0, 5.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
}
