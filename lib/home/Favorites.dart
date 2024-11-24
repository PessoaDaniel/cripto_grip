
import 'package:cripto_grip/home/FavoriteState.dart';
import 'package:cripto_grip/shared/CoinListTile.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  List<CoinListTile> favorites;
  Favorites({
    super.key,
    required this.favorites});

  @override
  State<Favorites> createState() => FavoriteState();
}