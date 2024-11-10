import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:cripto_grip/home/Favorites.dart';
import 'package:cripto_grip/home/Home.dart';
import 'package:cripto_grip/home/QuotesChart.dart';
import 'package:flutter/material.dart';

class HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("CriptoGrip"),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(child: Padding(padding:  const EdgeInsets.all(25), child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Padding(padding: const EdgeInsets.only(top: 10),
                child: QuotesChart()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Minhas moedas"),
                TextButton(
                    onPressed: () => Navigator.push(
                      context, MaterialPageRoute(
                        builder:(context) => CoinList())
                    ),
                    child: const Text("Ver todos", style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            Favorites()
          ],
        ),
      )));
  }
}