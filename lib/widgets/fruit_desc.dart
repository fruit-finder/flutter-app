import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/fruit.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/backBtn.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class FruitDescription extends StatefulWidget {
  Fruit fruit;
  FruitDescription(this.fruit);
  @override
  _FruitDescriptionState createState() => _FruitDescriptionState();
}

class _FruitDescriptionState extends State<FruitDescription> {
  Future<void> _launchBrowser(String url) async {
    try {
      _toastMsg("Loading...", Toast.LENGTH_SHORT);
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } catch (e) {
      _toastMsg(e.toString(), Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 22),
            child: ListView(
              children: [
                Column(
                  children: [
                    BackBtn(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 24),
                          child: Container(
                            height: 103,
                            width: 103,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.fruit.url,
                                  ),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          widget.fruit.getName(),
                          style: TextStyle(
                              color: HexColor('#FFFFFF').withOpacity(0.63),
                              fontSize: 26,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    buildFruitInfo(),
                    SizedBox(
                      height: 46,
                    ),
                    Center(
                      child: TextButton(
                          child: Text(
                            "SEARCH ON GOOGLE",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#FFFFFF').withOpacity(0.63),
                                decoration: TextDecoration.underline,
                                decorationThickness: 2),
                          ),
                          style: ButtonStyle(),
                          onPressed: () => _launchBrowser(
                              "https://www.google.com/search?q=" +
                                  widget.fruit.actual_name +
                                  " Fruit")),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Column buildFruitInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "BRIEF INFO",
            style: titleStyle(),
          ),
        ),
        Text(
          widget.fruit.description,
          style: textStyle(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 24),
          child: Text(
            "PROS",
            style: titleStyle(),
          ),
        ),
        Text(
          "1. ${widget.fruit.pros["1"]}",
          style: textStyle(),
        ),
        Text(
          "2. ${widget.fruit.pros["2"]}",
          style: textStyle(),
        ),
        Text(
          "3. ${widget.fruit.pros["3"]}",
          style: textStyle(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 24),
          child: Text(
            "CONS",
            style: titleStyle(),
          ),
        ),
        Text(
          "1. ${widget.fruit.cons["1"]}",
          style: textStyle(),
        ),
        Text(
          "2. ${widget.fruit.cons["2"]}",
          style: textStyle(),
        ),
        Text(
          "3. ${widget.fruit.cons["3"]}",
          style: textStyle(),
        )
      ],
    );
  }

  TextStyle textStyle() {
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: HexColor('#FFFFFF').withOpacity(0.75));
  }

  TextStyle titleStyle() {
    return TextStyle(
        fontSize: 18,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: HexColor('#E53232'));
  }

  void _toastMsg(String str, Toast length) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: length,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16);
  }
}
