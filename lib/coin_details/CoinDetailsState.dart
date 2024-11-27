import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:cripto_grip/services/coinsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinDetailsState extends State<CoinDetails> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _getCoinData(widget.coinId);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    print('Connectivity changed: $_connectionStatus');
  }

  Map<String, dynamic> _coin  = {};
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("CriptoGrip")
        ),
        body: _connectionStatus[0] !=  ConnectivityResult.none ?
        SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(25), child:  Column(
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
                       Padding(padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              _coin.isNotEmpty? const Text(
                                "Description",
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
                  "Last update: ${_currentDate.day}/${_currentDate.month}/${_currentDate.year} "
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
    ) : const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off)
            ],
          ),
        ));
  }
  _getCoinData (String id) {
    CoinsService().getById(id).then((response) {
      setState(() {
        _coin = jsonDecode(response.body);
      });
    });
  }
}