import 'package:http/http.dart';

class CoinsService {
  final String _baseUrl = "https://api.coingecko.com/api/v3/coins";

  Future<Response> getAll() {
    return get(Uri.parse("$_baseUrl/markets?vs_currency=usd"));
  }

  Future<Response> getById(String id) {
    return get(Uri.parse("$_baseUrl/$id"));
  }
}