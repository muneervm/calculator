import 'package:calculator/Common_Widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator/Providers/calculator_provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildDisplay(),
            SizedBox(height: 20),
            _buildButtonRow(
              context,
              ['AC', '+/-', '%', '/'],
              [Colors.grey, Colors.grey, Colors.grey, Colors.amber[700]!],
              [Colors.black, Colors.black, Colors.black, Colors.white],
            ),
            SizedBox(height: 10),
            _buildButtonRow(
              context,
              ['7', '8', '9', 'x'],
              [
                Colors.grey[850]!,
                Colors.grey[850]!,
                Colors.grey[850]!,
                Colors.amber[700]!,
              ],
              [Colors.white, Colors.white, Colors.white, Colors.white],
            ),
            SizedBox(height: 10),
            _buildButtonRow(
              context,
              ['4', '5', '6', '-'],
              [
                Colors.grey[850]!,
                Colors.grey[850]!,
                Colors.grey[850]!,
                Colors.amber[700]!,
              ],
              [Colors.white, Colors.white, Colors.white, Colors.white],
            ),
            SizedBox(height: 10),
            _buildButtonRow(
              context,
              ['1', '2', '3', '+'],
              [
                Colors.grey[850]!,
                Colors.grey[850]!,
                Colors.grey[850]!,
                Colors.amber[700]!,
              ],
              [Colors.white, Colors.white, Colors.white, Colors.white],
            ),
            SizedBox(height: 10),
            _buildLastRow(context),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (provider.calculatorModel.operator.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      '${provider.formatNumber(provider.calculatorModel.numOne)} ${provider.calculatorModel.operator}',
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                    ),
                  ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    provider.displayText,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white, fontSize: 96),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonRow(
    BuildContext context,
    List<String> texts,
    List<Color> colors,
    List<Color> textColors,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(texts.length, (index) {
        return CalculatorButton(
          buttonText: texts[index],
          buttonColor: colors[index],
          textColor: textColors[index],
          onPressed: () =>
              context.read<CalculatorProvider>().calculate(texts[index]),
        );
      }),
    );
  }

  Widget _buildLastRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CalculatorButton(
          buttonText: '0',
          buttonColor: Colors.grey[850]!,
          textColor: Colors.white,
          onPressed: () => context.read<CalculatorProvider>().calculate('0'),
        ),
        CalculatorButton(
          buttonText: '.',
          buttonColor: Colors.grey[850]!,
          textColor: Colors.white,
          onPressed: () => context.read<CalculatorProvider>().calculate('.'),
        ),
        CalculatorButton(
          buttonText: '=',
          buttonColor: Colors.amber[700]!,
          textColor: Colors.white,
          onPressed: () => context.read<CalculatorProvider>().calculate('='),
        ),
      ],
    );
  }
}
