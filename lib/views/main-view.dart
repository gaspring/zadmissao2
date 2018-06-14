import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zadmissao/views/cadastro-preliminar.dart';
import 'package:zadmissao/views/criar-preadmissao-view.dart';
import 'package:zadmissao/views/lista-preadmissao-view.dart';

class MainView extends StatefulWidget {
  static final String ROUTE = "/main";

  @override
  State<StatefulWidget> createState() => new _MainViewState();
}

class _MainViewState extends State<MainView> {
  static const int _CRIAR_PREADMISSAO = 0;
  static const int _HISTORICO_PREADMISSAO = 1;

  Widget _criarPreAdmissao;
  Widget _listarPreAdmissao;

  Widget _body;
  int _selectedTab;

  @override
  void initState() {
    _criarPreAdmissao = new CadastroPreliminarView();
    _listarPreAdmissao = new ListaPreAdmissaoView();
    _selectedTab = 0;
    _body = _criarPreAdmissao;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
          onTap: _onTap,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.add), title: new Text("Criar")),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.history), title: new Text("Histórico"))
          ],
          currentIndex: _selectedTab),
      body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                pinned: true,
                title: new Text('Bem vindo Gestor'),
                leading: new Container(),
              ),
            ];
          },
          body: new ListView(
            shrinkWrap: true,
            children: <Widget>[_body],
          )),
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
    }

    setState(() {
      _body = body;
      _selectedTab = position;
    });
  }
}
