import 'package:cripto_grip/home/CoinListTile.dart';
import 'package:cripto_grip/home/Favorites.dart';
import 'package:flutter/material.dart';

class FavoriteState extends State<Favorites> {
  List <dynamic> _favoriteList = [];

  @override
  Widget build(BuildContext context) {
    return _favoriteList.isNotEmpty ? Expanded(child:
    ListView(
        children: _loadFavorites()),
    ) :   Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: const Color.fromARGB(100, 224, 172, 94),
            borderRadius: BorderRadius.circular(10)
          ),
          child:
          const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 80, color: Color(0xffE0805E),),
                Text("Ainda sem favoritos por aqui", style: TextStyle(
                  fontWeight: FontWeight.bold
                ),)
              ]
          ),
    );
  }

  List<CoinListTile> _loadFavorites() {
    List<CoinListTile> favoriteList = [];
    _favoriteList.asMap().forEach((index, element) => favoriteList.add(
        CoinListTile(
          coinId: '',
          elementIndex: double.parse(index.toString()),
          coinName: '',
          price: 0,
        )
    ));
    return favoriteList;
  }
}