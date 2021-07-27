import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/hexColor.dart';

class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "BACK",
          style: TextStyle(
              color: HexColor('#FFFFFF').withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(97, 33),
          ),
          backgroundColor: MaterialStateProperty.all(
            HexColor('#E53232'),
          ),
          //alignment: Alignment.centerLeft,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ),
    );
  }
}
