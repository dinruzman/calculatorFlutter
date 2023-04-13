import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget{
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue), 
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget{
  const SimpleCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator>{

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;

      }else if(buttonText == "DEL"){
        equation = equation.substring(0,equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        
      }else if(buttonText == "="){
        expression = equation;

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL,cm)}';

        }catch(e){
          result = "Error";
        }

        equationFontSize = 38.0;
        resultFontSize = 48.0;
        
      }else{
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        } 

        equationFontSize = 48.0;
        resultFontSize = 38.0;
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
      return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(0.0),
            side: 
              const BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid
              )
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize:30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            )
          )
        ),
      );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding:const EdgeInsets.fromLTRB(10,20,10,10),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
              ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding:const EdgeInsets.fromLTRB(10,20,10,10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
              ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width:MediaQuery.of(context).size.width *.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C",1,Colors.redAccent),
                        buildButton("DEL",1,Colors.blueAccent),
                        buildButton("/",1,Colors.greenAccent),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("7",1,Colors.black54),
                        buildButton("8",1,Colors.black54),
                        buildButton("9",1,Colors.black54),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("4",1,Colors.black54),
                        buildButton("5",1,Colors.black54),
                        buildButton("6",1,Colors.black54),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("1",1,Colors.black54),
                        buildButton("2",1,Colors.black54),
                        buildButton("3",1,Colors.black54),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton(".",1,Colors.black54),
                        buildButton("0",1,Colors.black54),
                        buildButton("00",1,Colors.black54),
                      ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("x", 1, Colors.blue)
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue)
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue)
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.blue)
                      ]
                    ),
                  ], 
                ),
              )
            ],
          )
      ],)
    );
  }
}