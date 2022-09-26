import 'package:flutter/material.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String title,
      required String content,
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      required VoidCallback okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              ElevatedButton(
                onPressed: okBtnFunction,
                child: Text(okBtnText),
              ),
              ElevatedButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }
}
