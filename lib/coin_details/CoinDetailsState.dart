import 'dart:convert';

import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:cripto_grip/services/coinsService.dart';
import 'package:flutter/material.dart';

class CoinDetailsState extends State<CoinDetails> {

  Map<String, dynamic> _coin  = {};
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
                      color: const Color(0xffE0AC5E),
                      borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(_coin['image']['large']),
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
                  Text(_coin['name'], style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ))),
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
                     Text(
                       "\$ ${double.parse(_coin['market_data']['current_price']['usd'].toString()).toStringAsFixed(2)}",
                       style: const TextStyle(
                         fontWeight: FontWeight.bold
                       ),
                       textAlign: TextAlign.left,
                     ),
                   ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10), child: Row(
                    children: [
                      Text(
                        "Detalhes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  )),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: SingleChildScrollView(
                      child: Text(_coin['description']['en']),
                    ),
                  )
                ],
              ),
            )),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    "Ultima atualização ",
                    textAlign: TextAlign.right,
                    style: TextStyle(
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