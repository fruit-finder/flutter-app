import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/fruit.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/all_fruits.dart';
import 'package:fruit_classifier/widgets/backBtn.dart';
import 'package:fruit_classifier/widgets/fruit_desc.dart';

class ResultPage extends StatelessWidget {
  Future<List<Fruit>> data;
  LinkedHashMap<String, dynamic> output;
  List predFruits;
  File image;
  ResultPage(
    this.data,
    this.predFruits,
    this.output,
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    // print(output);
    List sortedKeys = output.keys.toList(growable: false)
      ..sort((k1, k2) => output[k1].compareTo(output[k2]!));
    LinkedHashMap sorted = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => output[k]);
    // final sorted = SplayTreeMap.from(
    //     output, (key1, key2) => output[key1].compareTo(output[key2]));
    var fruits = sorted.keys.toList().reversed.toList();
    // print(sorted);
    List<Fruit> finalPredFruits = predFruits as List<Fruit>;
    // print(finalPredFruits);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 22),
          child: ListView(
            children: [
              BackBtn(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45, bottom: 54),
                    child: ImageField(image),
                  ),
                  Text(
                    "YOUR FRUIT WAS IDENTIFIED AS",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#FFFFFF').withOpacity(0.51),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 44,
              ),
              Wrap(
                // direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6.0,
                      right: 4,
                    ),
                    child: PredFruitBtn(
                        finalPredFruits
                            .where((element) => element.pred_name == fruits[0])
                            .toList()[0],
                        30), //"${fruits.then((value) => value[0],).toString()}",
                  ),
                  predPercBtn('${output[fruits[0]]}', 16),
                ],
              ),
              OrText(),
              Row(
                children: [
                  PredFruitBtn(
                      finalPredFruits
                          .where((element) => element.pred_name == fruits[1])
                          .toList()[0],
                      25),
                  SizedBox(width: 4),
                  predPercBtn('${output[fruits[1]]}', 14),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PredFruitBtn(
                      finalPredFruits
                          .where((element) => element.pred_name == fruits[2])
                          .toList()[0],
                      25),
                  SizedBox(width: 4),
                  predPercBtn('${output[fruits[2]]}', 14),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllFruits(data))),
                child: Text(
                  "EXPLORE ALL FRUITS",
                  style: TextStyle(
                      color: HexColor('#FFFFFF').withOpacity(0.73),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(197, 40),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    HexColor('#E53232'),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text predPercBtn(String percent, double size) {
    return Text(
      percent + '%',
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: HexColor('#FFFFFF').withOpacity(0.63),
      ),
    );
  }
}

class PredFruitBtn extends StatelessWidget {
  Fruit fruit;
  final double size;
  PredFruitBtn(@required this.fruit, @required this.size);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FruitDescription(fruit)),
        );
      },
      child: Text(
        fruit.actual_name.toUpperCase(),
        style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w600,
            color: HexColor('#FFFFFF').withOpacity(0.63),
            decoration: TextDecoration.underline,
            decorationThickness: 2),
      ),
    );
  }
}

class ImageField extends StatelessWidget {
  File image;
  ImageField(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 129,
      width: 129,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: FileImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class OrText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OR",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HexColor('#FFFFFF').withOpacity(0.63),
            ),
          ),
        ],
      ),
    );
  }
}
