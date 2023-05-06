import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQ = '';
  var userA = '';
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
    return Scaffold(
        backgroundColor: Colors.deepPurple[100],
        // appBar: AppBar(

        //     //title: Text(widget.title),
        //     ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userQ,
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.deepPurple,
                              fontFamily: 'Montserrat'),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          userA,
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.deepPurple,
                              fontFamily: 'Montserrat'),
                        )),
                  )
                ],
              )),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        //Clear
                        if (index == 0) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQ = '';
                                  userA = '';
                                });
                              },
                              color: Color.fromARGB(255, 158, 125, 215),
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else if (index == 1) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQ = userQ.substring(0, userQ.length - 1);
                                });
                              },
                              color: Color.fromARGB(255, 158, 125, 215),
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else if (index == buttons.length - 1) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              color: Colors.deepPurple,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else if (index == buttons.length - 2) {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              color: Colors.deepPurple,
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                        } else {
                          return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQ += buttons[index];
                                });
                              },
                              color: isOperator(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.deepPurple[50],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Colors.deepPurple,
                              buttonText: buttons[index]);
                        }
                      })),
            ),
          ],
        ));
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '=' || x == '+') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQ = userQ;
    finalQ = finalQ.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQ);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userA = eval.toString();
  }
}
