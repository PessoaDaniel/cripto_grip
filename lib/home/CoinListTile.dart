import 'package:cripto_grip/coin_details/CoinDetais.dart';
import 'package:flutter/material.dart';

class CoinListTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return ListTile(
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
      );
  }
}