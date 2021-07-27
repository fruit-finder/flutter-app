import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/fruit.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/all_fruits.dart';

class ExploreAll extends StatelessWidget {
  const ExploreAll({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Future<List<Fruit>>? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 158,
              child: Center(
                child: Text(
                  "or",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#FFFFFF'),
                  ),
                ),
              ),
            ),
            TextButton(
              child: Text(
                "EXPLORE ALL",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#FFFFFF').withOpacity(0.63),
                    decoration: TextDecoration.underline,
                    decorationThickness: 2),
                textAlign: TextAlign.center,
              ),
              style: ButtonStyle(),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllFruits(this.data!)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
