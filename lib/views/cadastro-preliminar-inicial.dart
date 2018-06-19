import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:zadmissao/views/cadastro-preliminar.dart';

class CadastroPreliminarInicialView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CadastroPreliminarInicialState();
}

class _CadastroPreliminarInicialState
    extends State<CadastroPreliminarInicialView> {
  TextEditingController _textEditingControllerCPF;
  TextEditingController _textEditingControllerNomeCompleto;

  DialogUtils _dialog;

  @override
  void initState() {
    _textEditingControllerCPF = new TextEditingController();
    _textEditingControllerNomeCompleto = new TextEditingController();

    _dialog = new DialogUtils(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          _buildCPF(),
          _buildNomeCompleto(),
          _buildBotaoAvancar()
        ],
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

  Widget _buildNomeCompleto() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new TextField(
        maxLength: 50,
        controller: _textEditingControllerNomeCompleto,
        decoration: const InputDecoration(hintText: "Nome completo"),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildBotaoAvancar() {
    return new Container(
        padding: const EdgeInsets.all(4.0),
        child: new RaisedButton(
          color: Colors.amber,
          onPressed: _onButtonAvancarPress,
          child: new Text(
            "Avançar",
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }

  void _onButtonAvancarPress() {
    var cpf = _textEditingControllerCPF.text;
    var nome = _textEditingControllerNomeCompleto.text;

    if (!_validarCPF(cpf)) {
      _dialog.showAlertDialog("Ops...", "Seu CPF está inválido", "ok", "");
    } else {
      if (nome.trim().indexOf(" ") == -1) {
        _dialog.showAlertDialog("Ops...", "Digite seu sobrenome", "ok", "");
      } else {
        _transit(new CadastroPreliminarView(cpf: cpf, nome: nome));
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
