import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:flutter/material.dart';

class CoinListState extends State<CoinList>{

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('CriptoGrip'),
        ),
        body: Padding(
         padding: EdgeInsets.only(
           top: 12,
           bottom: 12,
           left: 30,
           right: 30
         ),
         child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none
              ),
            )
          ],
        )),
      );
  }
}