import 'package:flutter/cupertino.dart';

class Count extends ChangeNotifier {
  String _display = '0';
  String _firstOperand = '';
  String _secondOperand = '';
  String _operator = '';

  String get display => _display;
  void addDigit(String digit) {
    if (_operator.isEmpty) {
      // Add digits to the first operand
      _firstOperand += digit;
      _display = _firstOperand;
    } else {
      // Add digits to the second operand
      _secondOperand += digit;
      _display = _secondOperand;
    }
    _updateDisplay();
    notifyListeners();
  }

  void setOperation(String operation) {
    if (_firstOperand.isNotEmpty) {
      _operator = operation;
      _updateDisplay();
      notifyListeners();
    }
  }

  void _updateDisplay() {
    if (_operator.isEmpty) {
      _display = _firstOperand;
    } else if (_secondOperand.isEmpty) {
      _display = '$_firstOperand$_operator';
    } else {
      _display = '$_firstOperand$_operator$_secondOperand';
    }
    notifyListeners();
  }

  List<String> btn = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+'
  ];

  void calculate() {
    double num1 = double.tryParse(_firstOperand) ?? 0;
    double num2 = double.tryParse(_secondOperand) ?? 0;

    switch (_operator) {
      case '+':
        _display = (num1 + num2).toString();
        break;
      case '-':
        _display = (num1 - num2).toString();
        break;
      case '%':
        _display = (num1 % num2).toString();
        break;
      case '/':
        _display = (num2 != 0 ? (num1 / num2).toString() : 'Error');
        break;
      case '*':
        _display = (num1 * num2).toString();
        break;
      default:
        print("Error");
        break;
    }
    _firstOperand = _display;
    _secondOperand = '';
    _operator = '';
    _updateDisplay();
    notifyListeners();
  }

  void clear() {
    if (_secondOperand.isNotEmpty) {
      _secondOperand = _secondOperand.substring(0, _secondOperand.length - 1);
      _display = _secondOperand;
    } else if (_operator.isNotEmpty) {
      _operator = "";
    } else {
      _firstOperand = _firstOperand.substring(0, _firstOperand.length - 1);
      _display = _firstOperand;
    }
    notifyListeners();
  }

  void reset() {
    _display = '0';
    _firstOperand = '';
    _secondOperand = '';
    _operator = '';
    notifyListeners();
  }
}
