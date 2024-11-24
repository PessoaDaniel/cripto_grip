import 'package:cripto_grip/shared/CoinListTileState.dart';
import 'package:flutter/material.dart';

class CoinListTile extends StatefulWidget {

  double elementIndex = 0;
  String coinName = '';
  double price = 0;
  String? imageLink;
  String coinId = '';

  CoinListTile({
    super.key,
    required this.coinId,
    required this.elementIndex,
    required this.coinName,
    required this.price,
    this.imageLink
  }) {}

  @override
  State<StatefulWidget> createState() => CoinListTileState();

}