import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

class CriarPreAdmissaoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CriarPreAdmissaoState();
}

class _CriarPreAdmissaoState extends State<CriarPreAdmissaoView> {
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
        children: <Widget>[_buildCPF(), _buildVaga(), _buildDocumentos()],
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
        inputDecoration: new InputDecoration(
            hintText: "Digite seu CPF", labelText: "CPF"),
      ),
    );
  }

  Widget _buildVaga() {
    return new Container(
      padding: const EdgeInsets.all(2.0),
      child: new Text("Vaga"),
    );
  }

  Widget _buildDocumentos() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new ListTile(
                  title: new Text("RG"),
                  trailing: new Icon(Icons.camera_alt),
                )),
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                  child: new ListTile(
                    title: new Text("CPF"),
                    trailing: new Icon(Icons.camera_alt),
                  ),
                )
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new ListTile(
                  title: new Text("Título de eleitor"),
                  trailing: new Icon(Icons.camera_alt),
                ))
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new ListTile(
                  title: new Text("CTPS"),
                  trailing: new Icon(Icons.camera_alt),
                ))
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new ListTile(
                  title: new Text("PIS/PASEP"),
                  trailing: new Icon(Icons.camera_alt),
                ))
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new ListTile(
                  title: new Text("Reservista"),
                  trailing: new Icon(Icons.camera_alt),
                ))
              ],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new ListTile(
                  title: new Text("CNH"),
                  trailing: new Icon(Icons.camera_alt),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
