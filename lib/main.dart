import 'package:flutter/material.dart';
import 'package:zadmissao/views/login-view.dart';
import 'package:zadmissao/views/main-view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bem vindo Gestor',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new LoginView(),
      routes: <String, WidgetBuilder>{
        MainView.ROUTE: (BuildContext context) => new MainView()
      },
    );
  }
}