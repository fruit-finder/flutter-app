import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/fruit.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/backBtn.dart';
import 'package:fruit_classifier/widgets/fruit_desc.dart';
import 'package:http/http.dart' as http;

class AllFruits extends StatefulWidget {
  Future<List<Fruit>> data;
  AllFruits(this.data);
  @override
  _AllFruitsState createState() => _AllFruitsState();
}

class _AllFruitsState extends State<AllFruits> {
  //var data;
  late Future<List<Fruit>> filteredData;
  late Future<List<Fruit>> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    filteredData = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            top: 2,
            bottom: 4,
          ),
          child: Column(
            children: [
              BackBtn(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: TextField(
                  onChanged: (text) {
                    filteredData = data.then((value) => value
                        .where((k) => k.actual_name
                            .toLowerCase()
                            .startsWith(text.toLowerCase()))
                        .toList()) as Future<List<Fruit>>;
                    setState(() {
                      this.filteredData = filteredData;
                    });
                  },
                  style: TextStyle(color: Colors.white.withOpacity(0.77)),
                  autofocus: false,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent.shade200,
                      ),
                    ),
                    focusColor: Colors.white,
                    hintText: "SEARCH",
                    hintStyle: TextStyle(
                        color: HexColor('#FFFFFF').withOpacity(0.36),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    fillColor: HexColor('#333333'),
                    filled: true,
                    contentPadding: EdgeInsets.all(14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                  ),
                  cursorColor: Colors.grey,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: filteredData,
                    builder: (context, AsyncSnapshot snapshot) {
                      print(snapshot);
                      if (snapshot.hasData)
                        return FruitGrid(snapshot.data);
                      else
                        return Center(
                          child: CircularProgressIndicator(
                              color: HexColor('#E53232')),
                        );
                    }),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FruitGrid extends StatelessWidget {
  dynamic data;
  FruitGrid(this.data);

  @override
  Widget build(BuildContext context) {
    print(data);
    return GridView.count(
      mainAxisSpacing: 18,
      crossAxisSpacing: 12,
      crossAxisCount: 4,
      childAspectRatio: 0.7,
      children: List.generate(data.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FruitDescription(data[index]),
                    ),
                  );
                },
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(data[index].url),
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(data[index].actual_name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
