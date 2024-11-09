import 'package:cripto_grip/coin_details/CoinDetailsState.dart';
import 'package:flutter/material.dart';

class CoinDetails extends StatefulWidget {

  String coinId = '';
  CoinDetails(
      {
        super.key,
        required this.coinId
      });
  @override
  State<CoinDetails> createState() => CoinDetailsState();
}