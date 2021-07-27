import 'package:flutter/material.dart';
import 'package:fruit_classifier/DialogBox/policy_dialog.dart';
import 'package:fruit_classifier/model/hexColor.dart';

class BottomField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "FRUIT FINDER  ",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: HexColor('#FFFFFF')),
          ),
          Text(
            "TELLS YOU ALL THE FRUITY INFO   ",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HexColor('#FFFFFF').withOpacity(0.51)),
          ),
          TextButton(
              child: Text(
                "PRIVACY POLICY  ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#FFFFFF').withOpacity(0.51)),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PrivacyPolicy(mdFileName: 'privacy_policy.md');
                    });
              }),
        ],
      ),
      bottom: 20,
    );
  }
}
