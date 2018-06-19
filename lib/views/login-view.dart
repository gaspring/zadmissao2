import 'package:flutter/material.dart';
import 'package:zadmissao/api/login/login-service.dart';
import 'package:zadmissao/api/login/login-viewmodel.dart';
import 'package:zadmissao/settings/api-settings.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zadmissao/views/main-view.dart';

class LoginView extends StatefulWidget {
  static final String ROUTE = "/login";

  @override
  State<StatefulWidget> createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  SharedPreferences _sharedPreferences;

  DialogUtils _dialog;

  LoginService _loginService;

  TextEditingController _textFieldUserNameController;
  TextEditingController _textFieldPasswordConstroller;

  _LoginViewState() {
    _loginService = new LoginService();

    _textFieldUserNameController = new TextEditingController();
    _textFieldPasswordConstroller = new TextEditingController();
  }

  Widget _buildTextFieldUserName() {
    return new TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: _textFieldUserNameController,
      decoration: new InputDecoration(
          hintText: "Digite seu nome de usuário",
          labelText: "Usuário",
          counterStyle: null),
    );
  }

  Widget _buildTextFieldPassword() {
    return new TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      maxLength: 50,
      controller: _textFieldPasswordConstroller,
      decoration:
          new InputDecoration(hintText: "Digite sua senha", labelText: "Senha"),
    );
  }

  Widget _buildButtonLogin() {
    return new Container(
      margin: new EdgeInsets.only(top: 8.0),
      child: RaisedButton(
        child: new Text("Entrar", style: new TextStyle(color: Colors.white)),
        onPressed: _buttonLoginClick,
        color: Colors.amber,
      ),
    );
  }

  @override
  void initState() {
    _dialog = new DialogUtils(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(16.0),
          child: new ListView(
            children: <Widget>[
              _buildTextFieldUserName(),
              _buildTextFieldPassword(),
              _buildButtonLogin()
            ],
          ),
        ));
  }

  void _buttonLoginClick() async {
    var vm = new LoginViewModel(
        email: _textFieldUserNameController.text,
        password: _textFieldPasswordConstroller.text);

    _dialog.showProgressDialog();
    var r = await _loginService.login(vm);
    _dialog.dismiss();

    if (r != null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setString(ApiSettings.API_TOKEN, r.token);
      _sharedPreferences.setString(ApiSettings.ID_USER, r.idUser);

      Navigator.pushReplacementNamed(context, MainView.ROUTE);
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "ok", "");
    }
  }
}
