import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:flutter/material.dart';

class HomeOptionBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("My coins"),
          TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(
                  builder:(context) => CoinList())
              ),
              child: const Text("See all",
                style: TextStyle(color: Colors.black),
              ))
        ],
      );
  }
}