import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'getcoinprice.dart';
import 'coincolumns.dart';

class PriceScreen extends StatefulWidget {


  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  List<Widget> dataList = [];
  List<Widget> dataList2 = [];
  String selectedCurrency = 'USD';

  void updateUI(String selectedCurrency) async {

    dataList2.clear();
    dataList.clear();

    for (String coinName in cryptoList) {
      Widget containing = await coinInfo(currency: selectedCurrency,coin: coinName);
        dataList2.add(containing);
    }

    setState(() {
      dataList = dataList2;
    });
  }

  DropdownButton androidList() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(item);
    }

    return DropdownButton(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            updateUI(selectedCurrency);
          });
        });
  }

  CupertinoPicker iphoneList() {
    List<Text> dropdownIOS = [];
    for (String currency in currenciesList) {
      dropdownIOS.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: dropdownIOS,
    );
  }

  @override
  void initState(){
    super.initState();
    updateUI(selectedCurrency);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: dataList),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 0.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iphoneList() : androidList(),
          ),
        ],
      ),
    );
  }
}
