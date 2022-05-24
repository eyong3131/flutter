import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  // List of items in our dropdown menu
  var items = [
    'Window 1',
    'Window 2',
    'Window 3',
    'Window 4',
    'Window 5',
    'Window 6',
  ];
  String dropdownvalue = 'Window 1';
  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          width: 330,
          height: 40,
          //L T R B
          padding: const EdgeInsets.fromLTRB(15.0, 0, 16.0, 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: DropdownButtonFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '-Select Window-',
              ),
              value: dropdownvalue,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              }),
        ),
      );
}
