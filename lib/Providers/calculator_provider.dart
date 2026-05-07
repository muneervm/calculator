import 'package:calculator/Model/calculator_model.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  CalculatorModel _calculatorModel = CalculatorModel();

  CalculatorModel get calculatorModel => _calculatorModel;
  String get displayText => _calculatorModel.displayText;

  void calculate(String buttonText) {
    if (buttonText == 'AC') {
      _reset();
    } else if (buttonText == '%') {
      _handlePercentage();
    } else if (buttonText == '.') {
      _handleDecimal();
    } else if (buttonText == '+/-') {
      _handleSignChange();
    } else if (_isOperator(buttonText)) {
      _handleOperator(buttonText);
    } else if (buttonText == '=') {
      _handleOperator('=');
    } else {
      _handleNumber(buttonText);
    }

    _updateDisplay();
    notifyListeners();
  }

  void _reset() {
    _calculatorModel = CalculatorModel();
  }

  void _handleOperator(String btnText) {
    // If '=' pressed, perform pending operation and clear operator
    if (btnText == '=') {
      if (_calculatorModel.operator.isNotEmpty &&
          _calculatorModel.result.isNotEmpty) {
        _calculatorModel = _calculatorModel.copyWith(
          numTwo: double.parse(_calculatorModel.result),
        );
        String res = _compute(
          _calculatorModel.operator,
          _calculatorModel.numOne,
          _calculatorModel.numTwo,
        );
        _calculatorModel = _calculatorModel.copyWith(
          finalResult: res,
          numOne: double.parse(res),
          operator: '',
          result: '',
        );
      }
      return;
    }

    // Regular operator pressed
    if (_calculatorModel.result.isNotEmpty) {
      double current = double.parse(_calculatorModel.result);
      if (_calculatorModel.operator.isEmpty) {
        // first operator after entering a number
        _calculatorModel = _calculatorModel.copyWith(numOne: current);
      } else {
        // there is a pending operator -> compute
        _calculatorModel = _calculatorModel.copyWith(numTwo: current);
        String res = _compute(
          _calculatorModel.operator,
          _calculatorModel.numOne,
          _calculatorModel.numTwo,
        );
        _calculatorModel = _calculatorModel.copyWith(
          finalResult: res,
          numOne: double.parse(res),
        );
      }
    }

    _calculatorModel = _calculatorModel.copyWith(operator: btnText, result: '');
  }

  void _handlePercentage() {
    if (_calculatorModel.result.isNotEmpty) {
      double val = double.parse(_calculatorModel.result) / 100;
      String out = _doesContainDecimal(val.toString());
      _calculatorModel = _calculatorModel.copyWith(
        result: out,
        finalResult: out,
      );
    } else if (_calculatorModel.finalResult.isNotEmpty) {
      double val = double.parse(_calculatorModel.finalResult) / 100;
      String out = _doesContainDecimal(val.toString());
      _calculatorModel = _calculatorModel.copyWith(
        finalResult: out,
        numOne: double.parse(out),
      );
    }
  }

  void _handleDecimal() {
    if (!_calculatorModel.result.contains('.')) {
      String newResult = _calculatorModel.result.isEmpty
          ? '0.'
          : _calculatorModel.result + '.';
      _calculatorModel = _calculatorModel.copyWith(
        result: newResult,
        finalResult: newResult,
      );
    }
  }

  void _handleSignChange() {
    if (_calculatorModel.result.isNotEmpty) {
      String newResult = _calculatorModel.result.startsWith('-')
          ? _calculatorModel.result.substring(1)
          : '-' + _calculatorModel.result;
      _calculatorModel = _calculatorModel.copyWith(
        result: newResult,
        finalResult: newResult,
      );
    } else if (_calculatorModel.finalResult.isNotEmpty) {
      String newResult = _calculatorModel.finalResult.startsWith('-')
          ? _calculatorModel.finalResult.substring(1)
          : '-' + _calculatorModel.finalResult;
      _calculatorModel = _calculatorModel.copyWith(
        finalResult: newResult,
        numOne: double.tryParse(newResult) ?? _calculatorModel.numOne,
      );
    }
  }

  void _handleNumber(String btnText) {
    String newResult = _calculatorModel.result + btnText;
    _calculatorModel = _calculatorModel.copyWith(
      result: newResult,
      finalResult: newResult,
    );
  }

  String _add() {
    String result = (_calculatorModel.numOne + _calculatorModel.numTwo)
        .toString();
    _calculatorModel = _calculatorModel.copyWith(numOne: double.parse(result));
    return _doesContainDecimal(result);
  }

  String _sub() {
    String result = (_calculatorModel.numOne - _calculatorModel.numTwo)
        .toString();
    _calculatorModel = _calculatorModel.copyWith(numOne: double.parse(result));
    return _doesContainDecimal(result);
  }

  String _mul() {
    String result = (_calculatorModel.numOne * _calculatorModel.numTwo)
        .toString();
    _calculatorModel = _calculatorModel.copyWith(numOne: double.parse(result));
    return _doesContainDecimal(result);
  }

  String _div() {
    String result = (_calculatorModel.numOne / _calculatorModel.numTwo)
        .toString();
    _calculatorModel = _calculatorModel.copyWith(numOne: double.parse(result));
    return _doesContainDecimal(result);
  }

  String formatNumber(double val) {
    return _doesContainDecimal(val.toString());
  }

  String _doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return splitDecimal[0];
      }
    }
    return result;
  }

  bool _isOperator(String btnText) {
    return btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/';
  }

  void _updateDisplay() {
    String display;
    if (_calculatorModel.result.isNotEmpty) {
      display = _calculatorModel.result;
    } else {
      display = _calculatorModel.finalResult;
    }
    _calculatorModel = _calculatorModel.copyWith(displayText: display);
  }

  String _compute(String op, double a, double b) {
    String result = '0';
    if (op == '+') {
      result = (a + b).toString();
    } else if (op == '-') {
      result = (a - b).toString();
    } else if (op == 'x') {
      result = (a * b).toString();
    } else if (op == '/') {
      result = (b == 0) ? '0' : (a / b).toString();
    }
    return _doesContainDecimal(result);
  }
}
