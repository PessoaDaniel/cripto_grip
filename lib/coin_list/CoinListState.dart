import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:flutter/material.dart';
import 'package:cripto_grip/home/CoinListTile.dart';

class CoinListState extends State<CoinList> {

  List<dynamic> _coinList = [0,1,2,3,4,5,6,7,5,8,9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CriptoGrip'),
      ),
      body: Padding(
          padding:const  EdgeInsets.only(
              top: 12,
              bottom: 12,
              left: 30,
              right: 30
          ),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
              Expanded(child:
                ListView(
                  children: _loadAllCoins(),
                )
              )
            ],
          )),
    );
  }

  List<CoinListTile> _loadAllCoins() {
    List<CoinListTile> coinTiles = [];
    _coinList.asMap().forEach((index, element) => coinTiles.add(CoinListTile(
      elementIndex: double.parse(index.toString()),
    )));
    return coinTiles;
  }
}