import 'dart:convert';

import 'package:cripto_grip/home/Favorites.dart';
import 'package:flutter/material.dart';

class FavoriteState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 150,
    child:
    ListView(children: widget.favorites),
    );
  }
}