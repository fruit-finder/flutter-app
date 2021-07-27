import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/HomePage/credits.dart';

class CreditsBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Credits()));
          },
          child: Text(
            "Credits",
            style: TextStyle(
                color: HexColor('#FFFFFF').withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(88, 26)),
              backgroundColor: MaterialStateProperty.all(HexColor('#333333')),
              alignment: Alignment.center,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                  color: HexColor('#606060').withOpacity(0.67), width: 2))),
        ),
      ),
    );
  }
}
