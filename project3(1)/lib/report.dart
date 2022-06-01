import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';

class report extends StatefulWidget {
  const report({ Key? key }) : super(key: key);

  @override
  State<report> createState() => _reportState();
}

var _screenWidth;
var _screenHeight;

class _reportState extends State<report> {
  Map<String, double> dataMap = {
    "Transcript of Record (TOR)": 12,
    "Certification of Grades": 30,
    "Certification of Graduation": 40,
    "Certification of Enrollment": 28,
    "Diploma": 50,
    "Dropping Form": 12,
    "Changing Form": 17,
    "Adding Form": 12,
    "Clearance": 64,
    "Evaluation Form": 23,
  };
  final ScrollController horizontalScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      primary: false,
      child: AdaptiveScrollbar(
        controller: horizontalScroll,
        position: ScrollbarPosition.bottom,
        scrollToClickDelta: 75,
        scrollToClickFirstDelay: 200,
        scrollToClickOtherDelay: 50,
        sliderDecoration: const BoxDecoration(
            color: Color.fromARGB(255, 172, 186, 201),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        sliderActiveDecoration: const BoxDecoration(
            color: Color.fromRGBO(206, 206, 206, 100),
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        underColor: Colors.transparent,
        child: SingleChildScrollView(
          controller: horizontalScroll,
          primary: false,
          scrollDirection: Axis.horizontal,
          child: Container(
            height: _screenHeight*.80,
            child: PieChart(
              dataMap: dataMap,
              legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.left,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontSize: 20,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            ),
          ),
        ),
      ),
    );
  }
}