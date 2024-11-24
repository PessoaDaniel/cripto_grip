import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:cripto_grip/home/Favorites.dart';
import 'package:cripto_grip/home/Home.dart';
import 'package:cripto_grip/home/HomeChart.dart';
import 'package:cripto_grip/home/HomeOptionBar.dart';
import 'package:cripto_grip/home/QuotesChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeState extends State<Home>{

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }
      @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("CriptoGrip"),
          backgroundColor: Colors.white,
        ),
        body: _connectionStatus[0] != ConnectivityResult.none ?  SingleChildScrollView(child: Padding(padding:  const EdgeInsets.all(25), child: Column(
          children: [
            HomeChart(),
            HomeOptionBar(),
            Favorites()
          ],
        ),
      )) : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, size: 100, color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No network connection!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey
                        ),
                    )
                  ],
                )
              ],
            ),
        ));
  }
}