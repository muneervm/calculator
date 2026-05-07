class CalculatorModel {
  String displayText;
  double numOne;
  double numTwo;
  String result;
  String finalResult;
  String operator;
  String previousOperator;

  CalculatorModel({
    this.displayText = '0',
    this.numOne = 0,
    this.numTwo = 0,
    this.result = '',
    this.finalResult = '0',
    this.operator = '',
    this.previousOperator = '',
  });

  CalculatorModel copyWith({
    String? displayText,
    double? numOne,
    double? numTwo,
    String? result,
    String? finalResult,
    String? operator,
    String? previousOperator,
  }) {
    return CalculatorModel(
      displayText: displayText ?? this.displayText,
      numOne: numOne ?? this.numOne,
      numTwo: numTwo ?? this.numTwo,
      result: result ?? this.result,
      finalResult: finalResult ?? this.finalResult,
      operator: operator ?? this.operator,
      previousOperator: previousOperator ?? this.previousOperator,
    );
  }
}
