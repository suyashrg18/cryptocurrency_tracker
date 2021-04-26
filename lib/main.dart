import 'package:flutter/material.dart';
import 'package:bitcoin_tracker/bitcoin_price_selector.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white
      ),
      home:BitCoinPriceSelector(),
    );
  }
}


