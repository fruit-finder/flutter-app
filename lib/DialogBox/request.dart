import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<dynamic> showRequestDialog(BuildContext context, String permission) {
  String text =
      'This app needs camera access to take pictures for detecting fruits';
  if (permission == 'Storage')
    text =
        'This app needs media access to save pictures and some app related data';

  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('${permission} Permission'),
      content: Text(text),
      actions: <Widget>[
        TextButton(
          child: Text('Deny'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Settings'),
          onPressed: () => openAppSettings(),
        ),
      ],
    ),
  );
}
