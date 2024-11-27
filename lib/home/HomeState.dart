import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cripto_grip/coin_list/CoinList.dart';
import 'package:cripto_grip/home/Favorites.dart';
import 'package:cripto_grip/home/Home.dart';
import 'package:cripto_grip/home/HomeChart.dart';
import 'package:cripto_grip/home/NoFavoritesWidget.dart';
import 'package:cripto_grip/services/DatabaseService.dart';
import 'package:cripto_grip/services/coinsService.dart';
import 'package:cripto_grip/shared/CoinListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class HomeState extends State<Home> {

  List<CoinListTile> _favorites = [];
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _loadFavorites();
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
        body: _connectionStatus[0] != ConnectivityResult.none
            ? SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(25), child: Column(
              children: [
                const HomeChart(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("My coins"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(
                            builder:(context) => CoinList())
                        );
                        },
                        child: const Text("See all",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
                RefreshIndicator(onRefresh: () => _doRefresh(),
                  child: _favorites.isNotEmpty ?
                  Favorites(favorites: _favorites):
                  SizedBox(
                    height: 150,
                    child: ListView(
                      children: const [NoFavoritesWidget()],
                    ),
                  )
                )
              ],
            ),
            ))
            : const Center(
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

  void _loadFavorites() async {
    List<dynamic> favorites = await DatabaseService.findAll('favorite');
    List<CoinListTile> favoriteList = [];
    for (int i = 0; i < favorites.length; i++) {
      Response response = await CoinsService().getById(favorites[i]['api_id']);
      dynamic coinData = jsonDecode(response.body);
      favoriteList.add(
          CoinListTile(
            coinId: favorites[i]['api_id'],
            elementIndex: double.parse(i.toString()),
            coinName: coinData['name'],
            price: double.parse(
                coinData['market_data']['current_price']['usd'].toString()),
            imageLink: coinData['image']['small'],
          ));
    }
    setState(() {_favorites = favoriteList;});
  }
  Future<void> _doRefresh() async {
    _loadFavorites();
  }
}