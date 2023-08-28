import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '<' && input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
    } else if (value == '=') {
      var userInput = input;
      userInput = input.replaceAll('X', '*');
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalV = expression.evaluate(EvaluationType.REAL, cm);
      String finalValue = finalV.toString();
      if (finalValue.endsWith('.0')) {
        finalValue.substring(0, finalValue.length - 2);
      }
      output = finalValue;
    } else if (value == '=' && input.isEmpty) {
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 36, 51, 1),
      appBar: AppBar(
        backgroundColor:  const Color.fromRGBO(14, 36, 51, 1),
        elevation: 0,
        title: const Text('Calculator'),
        titleTextStyle: const TextStyle(fontSize: 15),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: const Color.fromRGBO(14, 36, 51, 1),

            //result area
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(input,
                    style: const TextStyle(color: Colors.white, fontSize: 25)),
                Text(output,
                    style: const TextStyle(color: Colors.white, fontSize: 35))
              ],
            ),
          )),
          Row(
            children: [
              button(text: '⌄', fontSize: 30.0, padding: 10.0),
              button(text: 'C'),
              button(text: 'X'),
              button(text: '/')
            ],
          ),
          Row(
            children: [
              button(text: '('),
              button(text: ')'),
              button(text: '%'),
              button(text: '*')
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '-')
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '+')
            ],
          ),
          Row(
            children: [
              button(
                text: '7',
              ),
              button(
                text: '8',
              ),
              button(
                text: '9',
              ),
              button(
                text: '',
              ),
            ],
          ),
          Row(
            children: [
              button(text: '0', padding: 20.0),
              button(text: '00', padding: 20.0),
              button(text: '.', padding: 20.0),
              button(text: '=', padding: 20.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget button(
      {text, tColor = Colors.white, padding = 20.0, fontSize = 18.0}) {
    return Expanded(
        child: Container(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(),
                    padding: EdgeInsets.all(padding),
                    backgroundColor: const Color.fromRGBO(11, 52, 79, 1)),
                onPressed: () => onButtonClick(text),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    //fontWeight: FontWeight.bold
                  ),
                ))));
  }
}
