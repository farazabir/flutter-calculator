import 'package:calculator/widgets/buttons.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var calInput = '';
  var calOutput = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.deepPurple.shade100,
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            calInput,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          child: Text(
                            calOutput,
                            style: TextStyle(fontSize: 25),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                    child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    //clear button 
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            calInput = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.black,
                      );
                    }
                    //Delete button 
                    else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            calInput =
                                calInput.substring(0, calInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    }
                    //Answer button
                    else if(index==buttons.length-1){
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                             getAnswer();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      );
                    }
                     else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            calInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  },
                )),
              )
            ],
          )),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void getAnswer(){
     String finalInput = calInput;
     finalInput = finalInput.replaceAll("x", "*");
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      calOutput = eval.toString();
  }
}
