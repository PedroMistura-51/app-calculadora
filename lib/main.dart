import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _firstOperand = '';
  String _operator = '';
  String _secondOperand = '';

  void _clearDisplay() {
    setState(() {
      _display = '0';
      _firstOperand = '';
      _operator = '';
      _secondOperand = '';
    });
  }

  void _appendNumber(String number) {
    setState(() {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    });
  }

  void _appendOperator(String operator) {
    setState(() {
      if (_firstOperand.isEmpty) {
        _firstOperand = _display;
        _operator = operator;
        _display = '0';
      }
    });
  }

  void _calculate() {
    double num1 = double.parse(_firstOperand);
    double num2 = double.parse(_display);
    double result;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      default:
        return;
    }

    setState(() {
      _display = result.toString();
      _firstOperand = '';
      _operator = '';
      _secondOperand = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 320,
          height: 480,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            children: [
              // Display area
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  _display,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              // Buttons
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    String buttonText = '';
                    
                    // Define the button text for each index
                    if (index < 9) {
                      buttonText = (index + 1).toString();
                    } else if (index == 9) {
                      buttonText = '0';
                    } else if (index == 10) {
                      buttonText = 'C';
                    } else if (index == 11) {
                      buttonText = '=';
                    } else if (index == 12) {
                      buttonText = '+';
                    } else if (index == 13) {
                      buttonText = '-';
                    } else if (index == 14) {
                      buttonText = '*';
                    } else if (index == 15) {
                      buttonText = '/';
                    } else if (index == 16) {
                      buttonText = '.';
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (buttonText == 'C') {
                          _clearDisplay();
                        } else if (buttonText == '=') {
                          _calculate();
                        } else if ('0123456789'.contains(buttonText)) {
                          _appendNumber(buttonText);
                        } else if ('+-*/'.contains(buttonText)) {
                          _appendOperator(buttonText);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200], // Alterado para backgroundColor
                        foregroundColor: Colors.black, // Alterado para foregroundColor
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
