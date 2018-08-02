import 'package:flutter/material.dart';
import 'package:zadmissao/views/login-view.dart';
import 'package:zadmissao/views/main-view.dart';
import 'package:zadmissao/views/signature-view.dart';
import 'package:zadmissao/views/splash-screen-view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bem vindo Gestor',
      theme: new ThemeData(
        primaryColor: new Color.fromRGBO(43, 186, 180, 1.0),
      ),
      home: new SignatureView(),
      routes: <String, WidgetBuilder>{
        MainView.ROUTE: (BuildContext context) => new MainView(),
        LoginView.ROUTE: (BuildContext context) => new LoginView()
      },
    );
  }
}