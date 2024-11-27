import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class CoinsService {
  final String _baseUrl = "https://api.coingecko.com/api/v3/coins";

  Future<Response> getAll() {
    return get(Uri.parse("$_baseUrl/markets?vs_currency=usd&x_cg_demo_api_key=CG-DnXABVRpGWtNiWeFZqcYVMEd"));
  }

  Future<Response> getById(String id) {
    return get(Uri.parse("$_baseUrl/$id?x_cg_demo_api_key=CG-DnXABVRpGWtNiWeFZqcYVMEd"));
  }

  Future<Response> getBylist(List<String> ids) {
    return get(Uri.parse("$_baseUrl/markets?vs_currency=usd&ids=${ids.join(',')}&x_cg_demo_api_key=CG-DnXABVRpGWtNiWeFZqcYVMEd"));
  }
  Future<Response> getChartData(String id) {
    return get(Uri.parse("$_baseUrl/$id/market_chart?vs_currency=usd&days=9&precision=2&interval=daily&x_cg_demo_api_key=CG-DnXABVRpGWtNiWeFZqcYVMEd"));
  }
  Future<Response> getByName(String name) {
    return get(Uri.parse("https://api.coingecko.com/api/v3/search?query=$name&x_cg_demo_api_key=CG-DnXABVRpGWtNiWeFZqcYVMEd"));
  }



  Future<List<dynamic>> getChartCoins() async {
    final Map<String, double> favoriteCoins = await getFavoriteCoins();
    List<dynamic> coinMap = [];

    if (favoriteCoins.isNotEmpty) {

    } else {
      List<String> ids = [];
      Response response = await get(Uri.parse("$_baseUrl/list"));
      List<dynamic> coinList = jsonDecode(response.body);
      ids.add(coinList[0]['id']);
      ids.add(coinList[1]['id']);
      ids.add(coinList[2]['id']);
      ids.add(coinList[3]['id']);
      ids.add(coinList[4]['id']);
      Response coinsListDataResponse = await getBylist(ids);
      List<dynamic> coinListSelection = await jsonDecode(coinsListDataResponse.body);
      for (var element in coinListSelection) {
        Response chartResponse = await getChartData(element['id']);
        Map<String, dynamic> chartData = await jsonDecode(chartResponse.body);
        coinMap.add({
        'id': element['id'],
        'name': element['name'],
        'chartData': chartData
        });
      }
    }
    return coinMap;
  }

  Future<Map<String, double>> getFavoriteCoins() async {
    return {};
  }

}