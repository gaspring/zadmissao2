import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  List<VagaViewModel> _vagas;

  DialogUtils _dialog;

  @override
  void initState() {
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
        itemCount: _vagas.length,
        itemBuilder: (context, index) {
          var vaga = _vagas[index];

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
    var vagas = await _vagaService.listarVagas();

    if (vagas != null) {
      setState(() {
        _vagas = vagas;
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

    if (res != null) {
      vaga.idPreAdmissao = res.idPreAdmissaoApp;
      _transit(new CriarPreAdmissaoView(
        vagaViewModel: vaga,
      ));
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
}
