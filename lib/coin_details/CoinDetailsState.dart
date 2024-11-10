import 'dart:convert';

import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:cripto_grip/services/coinsService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinDetailsState extends State<CoinDetails> {

  Map<String, dynamic> _coin  = {};
  DateTime _currentDate = DateTime.now();
  @override
  void initState()  {
    super.initState();
    _getCoinData(widget.coinId);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("CriptoGrip")
        ),
        body:Padding(padding: const EdgeInsets.all(25), child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _coin.isNotEmpty ? Image.network(_coin['image']['large']) : const
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()]),
                )
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding:const EdgeInsets.only(
                      top: 10,
                      bottom: 50
                  ), child:
                  _coin.isNotEmpty ? Text(_coin['name'], style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )) : const Text('')),
                ]),
            Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(100, 224, 172, 94)
                ),
                child:  Padding(padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    left: 20,
                    right: 20
                ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _coin.isNotEmpty ? Text(
                            "\$ ${double.parse(_coin['market_data']['current_price']['usd'].toString()).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.left,
                          ) : const Text(''),
                        ],
                      ),
                       Padding(padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              _coin.isNotEmpty? const Text(
                                "Detalhes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.left,
                              ) :const Text('')
                            ],
                          )),
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: _coin.isNotEmpty ? SingleChildScrollView(
                          child: Text(_coin['description']['en']),
                        ) : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()]
                        ),
                      )
                    ],
                  ),
                )),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Ultima atualização: ${_currentDate.day}/${_currentDate.month}/${_currentDate.year} "
                      "${_currentDate.hour}:${_currentDate.minute}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: Colors.grey
                  ),
                )
              ],
            ),
          ],
        ))
    );
  }
  _getCoinData (String id) {
    CoinsService().getById(id).then((response) {
      setState(() {
        _coin = jsonDecode(response.body);
      });
    });
  }
}