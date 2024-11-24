import 'dart:convert';

import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:cripto_grip/services/coinsService.dart';
import 'package:flutter/material.dart';
import 'package:cripto_grip/shared/CoinListTile.dart';

class CoinListState extends State<CoinList> {

  List<Widget> _coinList = [];
  bool _showSpin  = true;
  CoinListState() {
    _loadAllCoins();
  }

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
          child: _showSpin?
              const Center(
                child: CircularProgressIndicator(),
              )
              : Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
              Expanded(child:
                ListView(
                  children: _coinList,
                )
              )
            ],
          )),
    );
  }
  _loadAllCoins()  {
    CoinsService().getAll().then((response) {
      List<CoinListTile> coinTiles = [];
      List<dynamic> body = json.decode(response.body);
      body.forEach((coin) => coinTiles.add(CoinListTile(
          coinId: coin['id'],
          elementIndex: 0,
          coinName: coin['name'],
          imageLink: coin['image'],
          price: double.parse(coin['current_price'].toString()),
      )));
      setState(() {
        _coinList = coinTiles;
        _showSpin = false;
      });
    });
  }
}