import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fruit_classifier/model/hexColor.dart';

class PrivacyPolicy extends StatelessWidget {
  final double radius;
  final String mdFileName;
  const PrivacyPolicy({
    Key? key,
    this.radius = 8,
    required this.mdFileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 300)).then((value) {
              return rootBundle.loadString('assets/$mdFileName');
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  data: snapshot.data.toString(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        FlatButton(
          padding: EdgeInsets.all(8),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius)),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius)),
            ),
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            child: Text(
              "CLOSE",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#E53232')),
            ),
          ),
        )
      ]),
    );
  }
}
