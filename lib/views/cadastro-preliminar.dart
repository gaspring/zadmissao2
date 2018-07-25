import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zadmissao/api/vaga/pre-admissao-app-viewmodel.dart';
import 'package:zadmissao/api/vaga/preadmissao-app-input.dart';
import 'package:zadmissao/api/vaga/vaga-service.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/settings/api-settings.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:zadmissao/views/criar-preadmissao-view.dart';

class CadastroPreliminarView extends StatefulWidget {
  String nome;
  String cpf;

  CadastroPreliminarView({this.nome, this.cpf});

  @override
  State<StatefulWidget> createState() => new _CadastroPreliminarState();
}

class _CadastroPreliminarState extends State<CadastroPreliminarView> {
  VagaService _vagaService;

  List<VagaViewModel> _vagasFiltro;
  List<VagaViewModel> _vagas;

  DialogUtils _dialog;

  @override
  void initState() {
    _vagasFiltro = new List<VagaViewModel>();
    _vagas = new List<VagaViewModel>();
    _vagaService = new VagaService();
    _dialog = new DialogUtils(context);

    _listarVagas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cadastro Preliminar"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search), onPressed: _openBuscarVagaDialog)
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: _buildVaga(),
      ),
    );
  }

  Widget _buildVaga() {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: _vagasFiltro.length,
        itemBuilder: (context, index) {
          var vaga = _vagasFiltro[index];

          return new Card(
            child: new Container(
              padding: const EdgeInsets.all(4.0),
              child: new ListTile(
                onTap: () => _submit(vaga),
                title: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text(
                        "${vaga.codigoVaga}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text("${vaga.centroCusto}"),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text("${vaga.cargo}  "),
                    ),
                    new Container(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text("(${vaga.numeroPosicao}) ${vaga
                          .escalaPosicao}, ${vaga
                          .horaInicioPosicao} - ${vaga
                          .horaFimPosicao} (${vaga
                          .horaIntervaloPosicao})"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _listarVagas() async {
    _dialog.showProgressDialog();
    var vagas = await _vagaService.listarVagas();
    _dialog.dismiss();

    if (vagas != null) {
      _vagas.addAll(vagas);
      setState(() {
        _vagasFiltro = vagas;
      });
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "Ok", "");
    }
  }

  void _submit(VagaViewModel vaga) async {
    var preferences = await SharedPreferences.getInstance();
    var idUsuario = preferences.get(ApiSettings.ID_USER);

    var res = await _vagaService.criarPreAdmissao(PreAdmissaoAppInput(
        nome: widget.nome,
        CPF: widget.cpf,
        idUsuarioCriacao: idUsuario,
        idVaga: vaga.idVaga));

    vaga.cpf = widget.cpf;
    vaga.statusFotos = null;

    if (res != null) {
      vaga.idPreAdmissao = res.idPreAdmissaoApp;
      _transit(new CriarPreAdmissaoView(
          vagaViewModel: vaga,
          preAdmissaoAppViewModel: new PreAdmissaoAppViewModel(),
          isNew: true));
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "ok", "");
    }
  }

  void _transit(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }

  void _openBuscarVagaDialog() {
    TextEditingController textEditingControllerVaga =
        new TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Buscar Vaga"),
              content: new Container(
                padding: const EdgeInsets.all(4.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new TextField(
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      controller: textEditingControllerVaga,
                      decoration: const InputDecoration(
                          hintText: "Digite o código da vaga"),
                    ),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new RaisedButton(
                                child: new Text("Limpar"),
                                color: new Color.fromRGBO(43, 186, 180, 1.0),
                                onPressed: () {
                                  setState(() {
                                    _vagasFiltro = _vagas;
                                  });
                                  Navigator.pop(context);
                                })),
                        new Expanded(
                            child: new RaisedButton(
                                child: new Text("Pesquisar"),
                                color: new Color.fromRGBO(43, 186, 180, 1.0),
                                onPressed: () {
                                  var codigoVaga =
                                      textEditingControllerVaga.text;

                                  var filtro = _vagas
                                      .where((x) => x.codigoVaga
                                          .toUpperCase()
                                          .contains(codigoVaga.toUpperCase()))
                                      .toList();

                                  setState(() {
                                    _vagasFiltro = filtro;
                                  });

                                  Navigator.pop(context);
                                }))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
