import 'package:cripto_grip/home/Home.dart';
import 'package:flutter/material.dart';

class CriptoGrip extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: Home()
    );
  }
}