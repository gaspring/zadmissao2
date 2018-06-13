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
      child: new ListView(
        children: <Widget>[_buildCPF(), _buildVaga(), _buildDocumentos()],
      ),
    );
  }

  Widget _buildCPF() {
    return new Container(
      padding: const EdgeInsets.all(2.0),
      child: new MaskedTextField(
        maskedTextFieldController: _textEditingControllerCPF,
        mask: "xxx.xxx.xxx-xx",
        maxLength: 14,
        keyboardType: TextInputType.number,
        inputDecoration: new InputDecoration(
            hintText: "Write you Document here", labelText: "CPF"),
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
      padding: const EdgeInsets.all(2.0),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[new Text("RG"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("CPF"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("Título de eleitor"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("CTPS"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("PIS/PASEP"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("Reservista"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("CNH"), new Icon(Icons.camera_alt)],
            ),
          ),
          new Container(
            child: new Row(
              children: <Widget>[new Text("RG"), new Icon(Icons.camera_alt)],
            ),
          ),
        ],
      ),
    );
  }
}
