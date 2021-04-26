import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bitcoin_tracker/coin_data.dart';
import 'package:bitcoin_tracker/networking.dart';

class BitCoinPriceSelector extends StatefulWidget {
  @override
  _BitCoinPriceSelectorState createState() => _BitCoinPriceSelectorState();
}

class _BitCoinPriceSelectorState extends State<BitCoinPriceSelector> {
  String selectedCurrency = 'USD';
  String bitCoinPrice = '?';
  bool visible = false;
  /*for android*/
  DropdownButton createAndroidDropdown() {
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      list.add(new DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton(
      value: selectedCurrency,
      items: list,
      isExpanded: true,
      underline: Container(color: Colors.transparent),
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value;
          visible = true;
        });

        Networking networking = Networking(currency: selectedCurrency);
       try{
         var data = await networking.getBitcoinRate();
         double rate = data['rate'];
         setState(() {
           visible= false;
           bitCoinPrice = rate.toStringAsFixed(2);
         });

       }catch(err){
         setState(() {
           visible= false;
           bitCoinPrice = '?';
         });
       }

      },
    );
  }

  /*for iOS*/
  CupertinoPicker createIOSPicker () {
    List<Text> list = [];
    for (String currency in currenciesList) {
      list.add(new Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
       print(index);
      },
      children: list,
    );


  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(title: Text('💰 Crypto-Currency Tracker')),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '1 BTC = $bitCoinPrice $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visible,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: SpinKitDoubleBounce(
                    color: Colors.lightBlueAccent,
                    size: 100.0,
                  ),
                ),
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  width: double.infinity,
                  color: Colors.lightBlue,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.white),
                        left: BorderSide(width: 1.0, color: Colors.white),
                        right: BorderSide(width: 1.0, color: Colors.white),
                        bottom: BorderSide(width: 1.0, color:Colors.white),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    padding:EdgeInsets.symmetric(vertical: 5.0,horizontal: 15.0) ,
                    margin: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                    child: Platform.isAndroid ? createAndroidDropdown() : createIOSPicker(),
                  ),
                )
              ],
            )));
  }
}

/*

*/
