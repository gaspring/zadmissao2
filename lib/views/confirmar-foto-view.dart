import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zadmissao/api/file/atualizar-documento-preadmissao-input.dart';
import 'package:zadmissao/api/file/file-service.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/utils/dialog-utils.dart';

class ConfirmarFotoView extends StatefulWidget {
  DocumentoViewModel documento;
  String path;

  ConfirmarFotoView({this.documento, this.path});

  @override
  State<StatefulWidget> createState() => new _ConfirmarFotoState();
}

class _ConfirmarFotoState extends State<ConfirmarFotoView> {
  File _image;

  FileService _fileService;
  DialogUtils _dialog;

  @override
  void initState() {
    _image = new File(widget.path);
    _fileService = new FileService();
    _dialog = new DialogUtils(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Confirmar Foto"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new Image.file(_image),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new RaisedButton(
                  color: Colors.amber,
                  onPressed: _onPress,
                  child: new Text("Confirmar"),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onPress() async {
    _dialog.showProgressDialog();
    await _fileService.uploadFile(
        new AtualizarDocumentoPreAdmissaoInput(
            documento: widget.documento.key,
            idPreAdmissao: widget.documento.idPreAdmissaoApp),
        _image);
    _dialog.dismiss();

    widget.documento.key = widget.documento.key.replaceAll("VERSO", "");

    Navigator.pop(context);
    Navigator.pop(context);
  }
}