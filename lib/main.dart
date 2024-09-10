import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0"; 
  String _output = "0"; 
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  // Method to handle button presses
  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.tryParse(output) ?? 0.0;
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return; // Prevent multiple dots
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.tryParse(output) ?? 0.0;

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "×") {
        _output = (num1 * num2).toString();
      }
      if (operand == "÷") {
        if (num2 != 0) {
          _output = (num1 / num2).toString();
        } else {
          _output = "Error"; // Handle division by zero
        }
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText; // Replace initial zero with button text
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = double.tryParse(_output)?.toStringAsFixed(2) ?? _output;
    });
  }

  Widget buildButton(String buttonText,
      {Color color = Colors.blue, Color textColor = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            side: const BorderSide(width: 1.0, color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Colors.white, // This is the background color
            foregroundColor: textColor, // This is the text color
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vicky Calculator"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("÷", color: Colors.orange, textColor: Colors.black),
              ]),
              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("×", color: Colors.orange, textColor: Colors.black),
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-", color: Colors.orange, textColor: Colors.black),
              ]),
              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+", color: Colors.orange, textColor: Colors.black),
              ]),
              Row(children: [
                buildButton("CLEAR", color: Colors.red, textColor: Colors.black),
                buildButton("=", color: Colors.green, textColor: Colors.black),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
