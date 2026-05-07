import 'package:calculator/Screens/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator/Providers/calculator_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CalculatorProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator',
        theme: ThemeData.dark(),
        home: CalculatorScreen(),
      ),
    );
  }
}
