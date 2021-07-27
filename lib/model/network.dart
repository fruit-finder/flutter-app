import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fruit_classifier/model/fruit.dart';

class Network {
  final String url;
  Network(this.url);

  Future<List<Fruit>> fetchData() async {
    http.Response response = await http.get(Uri.parse(url));
    List<Fruit> fruits = [];

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var k in jsonData.keys) {
        var u = jsonData[k];
        Fruit fruit = Fruit(
          pred_name: k,
          actual_name: u['name'],
          cons: u['cons'],
          pros: u['pros'],
          url: u['image_url'],
          description: u['description'],
        );
        fruits.add(fruit);
      }
    } else
      print(response.statusCode);
    return fruits;
  }
}
