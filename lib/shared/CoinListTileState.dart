import 'package:cripto_grip/shared/CoinListTile.dart';
import 'package:flutter/material.dart';
import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:cripto_grip/services/DatabaseService.dart';
import 'dart:math';

class CoinListTileState  extends State<CoinListTile> {

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIsFavorite();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            _checkIsFavorite();
            return Padding(padding: const EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
                bottom: 10
            ), child: SizedBox(
              height: 50,
              child: ListView(
                children: [
                  !_isFavorite ? ListTile(
                    leading: const Icon(Icons.star_outlined),
                    title: const Text('Adicionar aos favoritos'),
                    onTap: () {
                      _addFavorite(context);
                    },
                  ) : ListTile(
                    leading: const Icon(Icons.star_half),
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
              child: widget.imageLink != null ? Image.network(widget.imageLink!) :
              const Icon(Icons.arrow_upward)
          )),
      title: Text(widget.coinName),
      subtitle: Text("\$ ${widget.price.toStringAsFixed(2)}",
          style: const TextStyle(
              fontSize: 12,
              color: Colors.grey
          )),
      trailing: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => CoinDetails(coinId: widget.coinId)
      )),
          icon: const Icon(Icons.add_circle_outlined)),
    );
  }

  _addFavorite(BuildContext context) {
    DatabaseService.insert('favorite', {
      "id": _getRandomString(5),
      "api_id" : widget.coinId
    }).then((result) {
        setState(() {
          _isFavorite = true;
        });
        Navigator.pop(context);
    });
  }

  _removeFavorite() {
    DatabaseService.removeOne('favorite', widget.coinId).then((result) {
      setState(() {
        _isFavorite = false;
      });
    });
  }

  void _checkIsFavorite() {
    DatabaseService.findAll('favorite').then((favorites) {
      favorites.forEach((favorite) {
        if (favorite['api_id'] == widget.coinId) {
            setState(() {
              _isFavorite = true;
            });
        }
      });
    });
  }

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}