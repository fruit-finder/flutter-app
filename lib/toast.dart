import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void invalidInputToast(String msg) {
  Fluttertoast.showToast(
      msg: msg, gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT);
}

void toastMsg(BuildContext context, String str, Toast length) {
  Fluttertoast.showToast(
      msg: str,
      backgroundColor: Theme.of(context).primaryColor,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16);
}
