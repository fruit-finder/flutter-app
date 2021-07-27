import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruit_classifier/main.dart';
import 'package:fruit_classifier/model/hexColor.dart';

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(milliseconds: 1500),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 192,
              height: 182,
              child: Image.asset('assets/images/app_icon.png'),
            ),
            SizedBox(height: 40),
            Text(
              "FRUITS FINDER",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: HexColor("#FFFFFF").withOpacity(0.63),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
                color: HexColor('#E53232').withOpacity(0.9)),
          ],
        ),
      ),
    );
  }
}
