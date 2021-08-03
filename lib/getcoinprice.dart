import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CoinPrice{

  String coin;

  CoinPrice({@required this.coin});

  Future<String> getPrice(String currency) async {

    Uri url = Uri.parse('https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=721EDBC5-36BA-43CC-A0DA-4619F58C82AA');
    http.Response response = await http.get(url);

    dynamic data = jsonDecode(response.body);

    String price = '1 $coin = ${data["rate"].toStringAsFixed(2)} $currency';

    print(price);

    return price;

  }

}