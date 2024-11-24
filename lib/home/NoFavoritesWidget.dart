import 'package:flutter/material.dart';

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text("No favorites yet :(", style: TextStyle(
                fontWeight: FontWeight.bold
            ))
          ]
      ),
    );
  }
}