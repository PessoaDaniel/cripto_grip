import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:flutter/material.dart';

class CoinListTile extends StatelessWidget {

  double _elementIndex = 0;
  String _coinName = '';
  double _price = 0;
  String? _imageLink;
  String _coinId = '';
  ListView menuOptions;
  CoinListTile({
    super.key,
    required coinId,
    required double elementIndex,
    required String coinName,
    required double price,
    required this.menuOptions,
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
                  child: menuOptions,
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

   void _showItems(BuildContext context) async {
    await showMenu(context: context,
        position:RelativeRect.fromLTRB(100, (150 + (70 * (_elementIndex + 1))), 100 ,100),
        items: [
          PopupMenuItem<String>(
              onTap: () {},
              child: const Text("Adicionar aos favoritos")
          )
        ]
    );
  }
}