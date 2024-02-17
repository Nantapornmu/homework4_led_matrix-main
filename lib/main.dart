import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 209, 192, 245),
        appBar: AppBar(
          title: Text(
            'CP-SU LED MATRIX',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 126, 84, 199),
        ),
        body: Center(
          child: LEDMatrixDisplay(),
        ),
      ),
    );
  }
}

class LEDMatrixDisplay extends StatefulWidget {
  @override
  _LEDMatrixDisplayState createState() => _LEDMatrixDisplayState();
}

class _LEDMatrixDisplayState extends State<LEDMatrixDisplay> {
  late int number;
  int topMargin = 0;

  @override
  void initState() {
    super.initState();
    // Generate the initial random number
    generateRandomNumber();
  }

  void generateRandomNumber() {
    // Set the initial number to 0
    setState(() {
      number = 0;
    });
  }

  void incrementNumber() {
    setState(() {
      if (number < 99) {
        number++;
      } else {
        number = 0; // When the value is 99, change it to 00
      }
    });
  }

  void decrementNumber() {
    setState(() {
      if (number > 0) {
        number--;
      } else {
        number = 99; // When the value is 00, change it to 99
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String numberAsString = number.toString().padLeft(2, '0');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_drop_up, size: 40), // Increase the size of the icon
                onPressed: () {
                  incrementNumber();
                },
                color: Colors.black,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.all(30),
                iconSize: 50,
              ),
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 80),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 10.0,
            ),
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numberAsString.split('').map((digit) {
              return Column(
                children: digitToMatrix[digit]!.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.split('').map((point) {
                      Widget cell = Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: point == '1'
                              ? Colors.lightGreenAccent
                              : Colors.grey[850],
                          shape: BoxShape.circle,
                        ),
                      );

                      if (point == '1') {
                        cell = Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            shape: BoxShape.circle,
                          ),
                        );
                      }

                      return cell;
                    }).toList(),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_drop_down, size: 40), // Increase the size of the icon
                onPressed: () {
                  decrementNumber();
                },
                color: Colors.black,
                splashColor: const Color.fromARGB(0, 0, 0, 0),
                highlightColor: Colors.transparent,
                padding: EdgeInsets.all(30),
                iconSize: 50,
              ),
            )
          ],
        ),
      ],
    );
  }
}

final Map<String, List<String>> digitToMatrix = {
  '0': [
    '01110',
    '10001',
    '10001',
    '10001',
    '10001',
    '10001',
    '01110'
  ],
  '1': [
    '00100',
    '01100',
    '00100',
    '00100',
    '00100',
    '00100',
    '01110'
  ],
  '2': [
    '01110',
    '10001',
    '00001',
    '01110',
    '10000',
    '10000',
    '11111'
  ],
  '3': [
    '01110',
    '10001',
    '00001',
    '01110',
    '00001',
    '10001',
    '01110'
  ],
  '4': [
    '00010',
    '00110',
    '01010',
    '10010',
    '11111',
    '00010',
    '00010'
  ],
  '5': [
    '11111',
    '10000',
    '11110',
    '00001',
    '00001',
    '10001',
    '01110'
  ],
  '6': [
    '01110',
    '10001',
    '10000',
    '11110',
    '10001',
    '10001',
    '01110'
  ],
  '7': [
    '11111',
    '00001',
    '00001',
    '00010',
    '00100',
    '00100',
    '00100'
  ],
  '8': [
    '01110',
    '10001',
    '10001',
    '01110',
    '10001',
    '10001',
    '01110'
  ],
  '9': [
    '01110',
    '10001',
    '10001',
    '01111',
    '00001',
    '10001',
    '01110'
  ]
};
