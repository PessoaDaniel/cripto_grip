import 'package:cripto_grip/home/QuotesChart.dart';
import 'package:flutter/material.dart';

class HomeChart  extends StatelessWidget{

  const HomeChart({super.key});

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 400,
        width: double.infinity,
        child: Padding(padding: const EdgeInsets.only(top: 10),
            child: QuotesChart()),
      );
  }
}