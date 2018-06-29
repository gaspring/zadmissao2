import 'package:flutter/material.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/preadmissao-app-dependente-viewmodel.dart';
import 'package:zadmissao/api/vaga/vaga-service.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:zadmissao/views/adicionar-dependente-view.dart';

class DependenteView extends StatefulWidget {
  final DocumentoViewModel documento;

  DependenteView({this.documento});

  @override
  State<StatefulWidget> createState() => new _DependenteState();
}

class _DependenteState extends State<DependenteView> {
  List<PreAdmissaoAppDependenteViewModel> _dependentes;

  VagaService _vagaService;
  DialogUtils _dialog;

  @override
  void initState() {
    _dependentes = new List<PreAdmissaoAppDependenteViewModel>();
    _vagaService = new VagaService();
    _dialog = new DialogUtils(context);

    _listarDependentes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.documento.nome}"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => _transit(new AdicionarDependenteView(
                  idPreAdmissaoApp: widget.documento.idPreAdmissaoApp)))
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
          itemBuilder: (context, index) {
            var dependente = _dependentes[index];

            return new Card(
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                child: new ListTile(
                  title: new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          padding: const EdgeInsets.all(2.0),
                          child: new Text(
                            dependente.nome,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                      new Container(
                          padding: const EdgeInsets.all(2.0),
                          child: new Text(dependente.grauParentesco))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _listarDependentes() async {
    _dialog.showProgressDialog();
    var lista = await _vagaService
        .listarDependentesPreAdmissaoApp(widget.documento.idPreAdmissaoApp);
    _dialog.dismiss();

    if (lista != null) {
      setState(() {
        _dependentes = lista;
      });
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "ok");
    }
  }

  void _transit(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }
}
