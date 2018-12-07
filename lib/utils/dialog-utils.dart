import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

class DialogUtils {
  BuildContext _context;

  DialogUtils(BuildContext context) {
    _context = context;
  }

  void showAlertDialog(String title, String message, String buttonTextOk,
      [String buttonTextCancel = ""]) {
    showDialog(
        context: _context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(message),
                actions: <Widget>[
                  new CupertinoDialogAction(
                      child: new Text(buttonTextCancel),
                      onPressed: () {
                        dismiss();
                      }),
                  new CupertinoDialogAction(
                      child: new Text(buttonTextOk),
                      onPressed: () {
                        dismiss();
                      }),
                ]));
  }

  void showProgressDialog() {
    Future.delayed(Duration(milliseconds: 10), () {
      showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Text("Carregando"),
                content: new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new CupertinoActivityIndicator(
                        animating: true,
                        radius: 20.0,
                      )
                    ],
                  ),
                ),
              ));
    });
  }

  void closeApp(String title, String message, String buttonTextOk,
      [String buttonTextCancel = ""]) {
    showDialog(
        context: _context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(message),
                actions: <Widget>[
                  new CupertinoDialogAction(
                      child: new Text(buttonTextCancel),
                      onPressed: () {
                        dismiss();
                      }),
                  new CupertinoDialogAction(
                    child: new Text(buttonTextOk),
                    onPressed: () => exit(0),
                  ),
                ]));
  }

  void dismiss() {
    Navigator.pop(_context);
  }
}
