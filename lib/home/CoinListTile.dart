import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:flutter/material.dart';

class CoinListTile extends StatelessWidget {

  double _elementIndex = 0;

  CoinListTile({super.key, required double elementIndex}) {
    _elementIndex = elementIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[],
        child: ListTile(
          onLongPress: () => _showItems(context),
          leading:const  Card(
            color: Color(0xffE0AC5E),
            child: Padding(padding: EdgeInsets.all(12), child: Icon(Icons.arrow_upward)),
          ),
          title: const Text("Coin"),
          subtitle: const Text("\$ 0.1",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              )),
          trailing: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => CoinDetails()
          )),
              icon: const Icon(Icons.remove_red_eye_outlined)),
        ));
   }

   void _showItems(BuildContext context) async {
    print((((_elementIndex + 1) * 200) + 10));
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

  _addFavorite () {

  }

  _removeFavorite() {

  }
}