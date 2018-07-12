import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zadmissao/api/file/atualizar-documento-preadmissao-input.dart';
import 'package:zadmissao/api/file/file-service.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:vector_math/vector_math_64.dart' as v3;

class ConfirmarFotoView extends StatefulWidget {
  DocumentoViewModel documento;
  String path;
  String verso;

  ConfirmarFotoView({this.documento, this.path, this.verso});

  @override
  State<StatefulWidget> createState() => new _ConfirmarFotoState();
}

class _ConfirmarFotoState extends State<ConfirmarFotoView> {
  File _image;

  FileService _fileService;
  DialogUtils _dialog;
  double _zoom;
  double _previousZoom;
  Offset _startingFocalPoint;
  Offset _previousOffset;
  Offset _offset;
  bool _scaleEnable;
  bool _doubleTapEnable;

  @override
  void initState() {
    _image = new File(widget.path);
    _fileService = new FileService();
    _dialog = new DialogUtils(context);
    _zoom = 1.0;
    _previousZoom = null;
    _offset = Offset.zero;
    _scaleEnable = true;
    _doubleTapEnable = true;

    super.initState();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _zoom = _previousZoom * details.scale;
    });
    final Offset normalizeOffset =
        (_startingFocalPoint - _previousOffset) / _previousZoom;
    _offset = details.focalPoint - normalizeOffset * _zoom;
  }

  void _handleScaleReset() {
    setState(() {
      _zoom = 1.0;
      _offset = Offset.zero;
    });
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
            new GestureDetector(
              onScaleStart: _scaleEnable ? _handleScaleStart : null,
              onScaleUpdate: _scaleEnable ? _handleScaleUpdate : null,
              onScaleEnd: (ScaleEndDetails details) {
                _previousZoom = null;
              },
              onDoubleTap: _doubleTapEnable ? _handleScaleReset : null,
              child: new Transform(
                transform:
                    new Matrix4.diagonal3(new v3.Vector3(_zoom, _zoom, _zoom)),
                alignment: FractionalOffset.center,
                child: new Image.file(_image),
              ),
            ),
            // new Image.file(compressImage(_image)),
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
        _image,
        widget.documento.dependenteOuAdmissao);
    _dialog.dismiss();

    widget.documento.key = widget.documento.key.replaceAll("VERSO", "");

    if (widget.verso == "Frente") {
      Navigator.pop(context);
      Navigator.pop(context, "doneSendingPhotoToServer-Frente");
      Navigator.pop(context);
    } else if (widget.verso == "Verso") {
      Navigator.pop(context);
      Navigator.pop(context, "doneSendingPhotoToServer-Verso");
      Navigator.pop(context);
    }
  }
}
