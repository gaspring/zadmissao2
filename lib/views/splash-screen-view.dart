import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zadmissao/api/login/login-service.dart';
import 'package:zadmissao/api/login/login-viewmodel.dart';
import 'package:zadmissao/settings/api-settings.dart';
import 'package:zadmissao/views/login-view.dart';
import 'package:zadmissao/views/main-view.dart';
import 'dart:async';

class SplashScreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenView> {
  LoginService _loginService;

  @override
  void initState() {
    _loginService = new LoginService();
    _checkSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.amber,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new CupertinoActivityIndicator(
            radius: 30.0,
          )
        ],
      ),
    );
  }

  void _checkSession() async {
    var preferences = await SharedPreferences.getInstance();

    var token = preferences.getString(ApiSettings.API_TOKEN);

    if (token != null && !(token.length == 0)) {
      var username = preferences.getString(ApiSettings.USERNAME);
      var password = preferences.getString(ApiSettings.PASSWORD);

      if (username == null || password == null) {
        Navigator.pushReplacementNamed(context, LoginView.ROUTE);
      }

      var auth = await _loginService
          .login(new LoginViewModel(email: username, password: password),context);

      if (auth != null) {
        preferences.setString(ApiSettings.API_TOKEN, auth.token);
        preferences.setString(ApiSettings.ID_USER, auth.idUser);

        Navigator.pushReplacementNamed(context, MainView.ROUTE);
      }
    } else {
      Navigator.pushReplacementNamed(context, LoginView.ROUTE);
    }
  }
}
