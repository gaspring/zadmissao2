import 'package:flutter/material.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/preadmissao-app-dependente-viewmodel.dart';

class DependenteView extends StatefulWidget {
  final DocumentoViewModel documento;

  DependenteView({this.documento});

  @override
  State<StatefulWidget> createState() => new _DependenteState();
}

class _DependenteState extends State<DependenteView> {
  List<PreAdmissaoAppDependenteViewModel> _dependentes;

  @override
  void initState() {
    _dependentes = new List<PreAdmissaoAppDependenteViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.documento.nome}"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add), onPressed: () => null)
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: _dependentes.length > 0
            ? _buildListaDependentes()
            : _buildListaDependenteVazia(),
      ),
    );
  }

  Widget _buildListaDependenteVazia() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new Center(
        child: new Text("Vocë não possuí dependentes cadastrados"),
      ),
    );
  }

  Widget _buildListaDependentes() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _dependentes.length,
          itemBuilder: (context, index) => null),
    );
  }
}
