import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_classifier/model/fruit.dart';
import 'package:fruit_classifier/model/network.dart';

Future<List<Fruit>> getData(BuildContext context) async {
  Future<List<Fruit>> data;
  String url = 'https://mlproject987.herokuapp.com/fruits';
  try {
    Network network = Network(url);
    data = network.fetchData();
    return data;
  } catch (e) {
    Fluttertoast.showToast(
        msg: "Check Your Network!",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Theme.of(context).primaryColor);
    return [
      Fruit(
          pred_name: '',
          actual_name: '',
          pros: '',
          cons: '',
          url: '',
          description: '')
    ];
  }
}
