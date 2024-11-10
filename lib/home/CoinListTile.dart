import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:cripto_grip/services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CoinListTile extends StatelessWidget {

  double _elementIndex = 0;
  String _coinName = '';
  double _price = 0;
  String? _imageLink;
  String _coinId = '';
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();


  CoinListTile({
    super.key,
    required coinId,
    required double elementIndex,
    required String coinName,
    required double price,
    String? imageLink
  }) {
    _coinId = coinId;
    _elementIndex = elementIndex;
    _coinName = coinName;
    _imageLink = imageLink;
    _price = price;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
          onLongPress: () => showModalBottomSheet<void>(
            context: context,
              builder: (BuildContext context) {
                return Padding(padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                    bottom: 10
                ), child: SizedBox(
                  height: 50,
                  child: ListView(
                    children: [
                      !_isFavorite() ? ListTile(
                        leading: const Icon(Icons.star),
                        title: const Text('Adicionar aos favoritos'),
                        onTap: () {
                          _addFavorite(context);
                        },
                      ) : ListTile(
                        leading: const Icon(Icons.star_border_outlined),
                        title: const Text('Remover dos favoritos'),
                        onTap: () {
                          _removeFavorite();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ));
              }
          ),
          leading:Card(
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: Padding(padding: const EdgeInsets.all(12),
                child: _imageLink != null ? Image.network(_imageLink!) :
                const Icon(Icons.arrow_upward)
          )),
          title: Text(_coinName),
          subtitle: Text("\$ ${_price.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              )),
          trailing: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => CoinDetails(coinId: _coinId)
          )),
              icon: const Icon(Icons.remove_red_eye_outlined)),
        );
   }

   _addFavorite(BuildContext context) {
    DatabaseService.insert('favorite', {
      "id": _getRandomString(5),
      "api_id" : _coinId
    }).then((result) => Navigator.pop(context));
   }

   _removeFavorite() {
   }

   bool _isFavorite() {
    return false;
  }

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}