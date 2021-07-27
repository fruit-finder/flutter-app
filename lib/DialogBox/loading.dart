import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/hexColor.dart';

AlertDialog onLoading() {
  return AlertDialog(
    backgroundColor: HexColor('#333333'),
    content: Container(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularProgressIndicator(color: HexColor('#E53232')),
          Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
