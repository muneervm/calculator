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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildDisplay(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 430,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: Color(0xFF242D44),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),

                    _buildButtonRow(
                      context,
                      ['7', '8', '9', 'AC'],
                      [
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.blueGrey[800]!,
                      ],
                      [Colors.white, Colors.white, Colors.white, Colors.white],
                    ),
                    SizedBox(height: 8),
                    _buildButtonRow(
                      context,
                      ['4', '5', '6', '+'],
                      [
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.blue[700]!,
                      ],
                      [Colors.white, Colors.white, Colors.white, Colors.white],
                    ),
                    SizedBox(height: 8),

                    _buildButtonRow(
                      context,
                      ['1', '2', '3', '-'],
                      [
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.blue[700]!,
                      ],
                      [Colors.white, Colors.white, Colors.white, Colors.white],
                    ),
                    SizedBox(height: 8),

                    _buildButtonRow(
                      context,
                      ['.', '0', '/', 'x'],
                      [
                        Colors.grey[850]!,
                        Colors.grey[850]!,
                        Colors.blue[700]!,
                        Colors.blue[700]!,
                      ],
                      [Colors.white, Colors.white, Colors.white, Colors.white],
                    ),
                    SizedBox(height: 8),

                    _buildBottomRow(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (provider.calculatorModel.operator.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${provider.formatNumber(provider.calculatorModel.numOne)} ${provider.calculatorModel.operator}',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  provider.displayText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
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
      children: List.generate(texts.length, (index) {
        return Expanded(
          child: CalculatorButton(
            buttonText: texts[index],
            buttonColor: colors[index],
            textColor: textColors[index],
            onPressed: () =>
                context.read<CalculatorProvider>().calculate(texts[index]),
          ),
        );
      }),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CalculatorButton(
            buttonText: 'RESET',
            buttonColor: Colors.blueGrey[800]!,
            textColor: Colors.white,
            onPressed: () => context.read<CalculatorProvider>().calculate('AC'),
          ),
        ),
        Expanded(
          child: CalculatorButton(
            buttonText: '=',
            buttonColor: Colors.red,
            textColor: Colors.white,
            onPressed: () => context.read<CalculatorProvider>().calculate('='),
          ),
        ),
      ],
    );
  }
}
