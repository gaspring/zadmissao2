import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zadmissao/views/cadastro-preliminar-inicial.dart';
import 'package:zadmissao/views/cadastro-preliminar.dart';
import 'package:zadmissao/views/criar-preadmissao-view.dart';
import 'package:zadmissao/views/em-analise-view.dart';
import 'package:zadmissao/views/lista-preadmissao-view.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class MainView extends StatefulWidget {
  static final String ROUTE = "/main";

  @override
  State<StatefulWidget> createState() => new _MainViewState();
}

class _MainViewState extends State<MainView> {
  // FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  static const int _EM_ANALISE = 0;
  static const int _CRIAR_PREADMISSAO = 1;
  static const int _HISTORICO_PREADMISSAO = 2;

  Widget _criarPreAdmissao;
  Widget _listarPreAdmissao;
  Widget _emAnalise;

  Widget _body;
  int _selectedTab;

  @override
  void initState() {
    _criarPreAdmissao = new CadastroPreliminarInicialView();
    _listarPreAdmissao = new ListaPreAdmissaoView();
    _emAnalise = new EmAnaliseView();
    _selectedTab = 0;
    _body = _emAnalise;

    // initFirebase();

    super.initState();
  }

  // void initFirebase() {
  //    _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) {
  //       print("onMessage $message");
  //     },
  //     onResume: (Map<String, dynamic> message) {
  //       print("onResume $message");
  //     },
  //     onLaunch: (Map<String, dynamic> message) {
  //       print("onLaunch $message");
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.getToken().then((token) {
  //     print(token);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Bem vindo Gestor"),
      ),
      bottomNavigationBar: new BottomNavigationBar(
          onTap: _onTap,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.query_builder),
                title: new Text("Em análise")),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.add), title: new Text("Admitir")),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.history), title: new Text("Histórico")),
          ],
          currentIndex: _selectedTab),
      body: _body,
    );
  }

  void _onTap(int position) {
    Widget body;

    switch (position) {
      case _CRIAR_PREADMISSAO:
        body = _criarPreAdmissao;
        break;
      case _HISTORICO_PREADMISSAO:
        body = _listarPreAdmissao;
        break;
      case _EM_ANALISE:
        body = _emAnalise;
        break;
    }

    setState(() {
      _body = body;
      _selectedTab = position;
    });
  }
}
