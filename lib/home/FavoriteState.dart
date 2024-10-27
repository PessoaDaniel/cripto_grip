import 'package:cripto_grip/home/CoinListTile.dart';
import 'package:cripto_grip/home/Favorites.dart';
import 'package:flutter/material.dart';

class FavoriteState extends State<Favorites> {
  List <dynamic> _favoriteList = [1,2,3,4,5,6,7,8,9,10];

  @override
  Widget build(BuildContext context) {
    return _favoriteList.isNotEmpty ? Expanded(child:
    ListView(
        children: _loadFavorites()),
    ) : const SizedBox(
      height: 200,
      width: double.infinity,
      child: ColoredBox(
          color: Color.fromARGB(100, 224, 172, 94),
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 80, color: Color(0xffE0805E),),
                Text("Ainda sem favoritos por aqui")
              ]
          )),
    );
  }

  List<CoinListTile> _loadFavorites() {
    List<CoinListTile> favoriteList = [];
    _favoriteList.forEach((element) => favoriteList.add(CoinListTile()));
    return favoriteList;
  }
}