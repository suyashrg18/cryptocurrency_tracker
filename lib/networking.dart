import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitcoin_tracker/constants.dart';

class Networking {
  final String currency;

  Networking({this.currency});

  Future getBitcoinRate() async {
    var url = Uri.parse(base_url + currency);
    http.Response response = await http.get(url, headers: {'X-CoinAPI-Key': api_key});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Response body err: ${response.body}');
      print(response.statusCode);
    }
  }


}
