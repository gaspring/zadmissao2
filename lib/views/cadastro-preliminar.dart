import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

class CadastroPreliminarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CadastroPreliminarState();
}

class _CadastroPreliminarState extends State<CadastroPreliminarView> {
  TextEditingController _textEditingControllerCPF;

  @override
  void initState() {
    _textEditingControllerCPF = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[_buildCPF(), _buildVaga(), _buildBotaoCriar()],
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
    return new Container(
      padding: const EdgeInsets.all(2.0),
      child: new Text("Vagas"),
    );
  }

  Widget _buildBotaoCriar() {
    return new Container(
        padding: const EdgeInsets.all(4.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new RaisedButton(
                onPressed: () => null,
                child: new Text("Criar"),
                color: Colors.amber,
              ),
            )
          ],
        ));
  }
}
