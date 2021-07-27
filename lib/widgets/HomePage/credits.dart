import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/backBtn.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: BackBtn(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 25),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    "CREDITS",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.63)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0, bottom: 8),
                    child: nameField("Akshi Gupta"),
                  ),
                  Text(
                    'Spent Days Collecting data for our model which helped us build our FRUITS FINDER App, Trained the model.',
                    style: descTextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 8),
                    child: nameField("Mayank Srivastava"),
                  ),
                  Text(
                    'Our Designer who did backend development, hosting and all that server and API related stuff.',
                    style: descTextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 40),
                    child: nameField('Abhishek Garg'),
                  ),
                  Text(
                    'Our App Developer who also did various optimisations to Deep Learning Model used in the app.',
                    style: descTextStyle(),
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Like our app? ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      TextButton(
                          child: Text(
                            "Rate us",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#E53232').withOpacity(0.63),
                                decoration: TextDecoration.underline,
                                decorationThickness: 2),
                          ),
                          style: ButtonStyle(),
                          onPressed: () {
                            Fluttertoast.showToast(
                              msg: "Coming Soon",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM_LEFT,
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align nameField(String name) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: HexColor('#E53232')),
      ),
    );
  }

  TextStyle descTextStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: HexColor('#C9C9C9'),
    );
  }

  TextStyle nameTextStyle() {
    return TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: HexColor('#E53232'));
  }
}
