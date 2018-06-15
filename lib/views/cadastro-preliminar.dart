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
  @override
  State<StatefulWidget> createState() => new _CadastroPreliminarState();
}

class _CadastroPreliminarState extends State<CadastroPreliminarView> {
  TextEditingController _textEditingControllerCPF;

  VagaService _vagaService;

  List<VagaViewModel> _vagas;

  DialogUtils _dialog;

  @override
  void initState() {
    _textEditingControllerCPF = new TextEditingController();
    _vagas = new List<VagaViewModel>();
    _vagaService = new VagaService();
    _dialog = new DialogUtils(context);

    _listarVagas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[_buildCPF(), _buildVaga()],
        ),
      ),
    );
  }

  Widget _buildCPF() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new MaskedTextField(
        maskedTextFieldController: _textEditingControllerCPF,
        mask: "xxx.xxx.xxx-xx",
        maxLength: 14,
        keyboardType: TextInputType.number,
        inputDecoration:
            new InputDecoration(hintText: "Digite seu CPF", labelText: "CPF"),
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
    if (!_validarCPF(_textEditingControllerCPF.value.text))
      _dialog.showAlertDialog("Ops...", "CPF digitado é inválido", "Ok", "");
    else {
      var preferences = await SharedPreferences.getInstance();
      var idUsuario = preferences.get(ApiSettings.ID_USER);

      var res = await _vagaService.criarPreAdmissao(PreAdmissaoAppInput(
          CPF: _textEditingControllerCPF.value.text,
          idUsuarioCriacao: idUsuario,
          idVaga: vaga.idVaga));

      vaga.cpf = _textEditingControllerCPF.value.text;

      if (res) {
        _transit(new CriarPreAdmissaoView(
          vagaViewModel: vaga,
        ));
      }
    }
  }

  void _transit(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }

  var _weightSsn = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

  int _calculate(String str, List<int> weight) {
    var sum = 0;
    var i = str.length - 1;
    var digit;

    while (i >= 0) {
      digit = int.parse(str.substring(i, i + 1));
      sum += digit * weight[weight.length - str.length + i];
      i--;
    }
    sum = 11 - sum % 11;
    return sum > 9 ? 0 : sum;
  }

  bool _validarCPF(String ssn) {
    ssn = ssn.replaceAll("-", "").replaceAll(".", "");

    if (ssn.length == 0) return false;

    RegExp regExp = new RegExp(ssn[0] + "{11}");
    var match = regExp.allMatches(ssn).length > 0;

    if (ssn == null || ssn.length != 11 || match) return false;

    var digit1 = _calculate(ssn.substring(0, 9), _weightSsn);
    var digit2 =
        _calculate(ssn.substring(0, 9) + digit1.toString(), _weightSsn);
    return ssn == ssn.substring(0, 9) + digit1.toString() + digit2.toString();
  }
}
