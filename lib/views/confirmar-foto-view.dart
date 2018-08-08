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
  bool camera;

  ConfirmarFotoView({this.documento, this.path, this.verso, this.camera});

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
        title: new Text(widget.documento.nome + " - " + widget.verso),
      ),
      body: new Stack(
        children: <Widget>[
          new DragImage(Offset(0.0, 0.0), _image),
          Positioned(
            bottom: 0.0,
            child: new Container(
                width: 370.0,
                child: new RaisedButton(
                  color: new Color.fromRGBO(43, 186, 180, 1.0),
                  onPressed: _onPress,
                  child: new Text("Confirmar"),
                )),
          ),
        ],
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

    await _image.delete(recursive: false);

    _backToPreAdmissaoView();
  }

  void _backToPreAdmissaoView() {
    if (widget.camera) {
      if (widget.verso == "Frente") {
        Navigator.pop(context);
        Navigator.pop(context, "doneSendingPhotoToServer-Frente");
        Navigator.pop(context);
      } else if (widget.verso == "Verso") {
        Navigator.pop(context);
        Navigator.pop(context, "doneSendingPhotoToServer-Verso");
        Navigator.pop(context);
      }
    } else {
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
}

class DragImage extends StatefulWidget {
  final Offset position;
  final File image;

  DragImage(this.position, this.image);

  @override
  DragImageState createState() => DragImageState();
}

class DragImageState extends State<DragImage> {
  double _zoom;
  double _previousZoom;
  Offset _startingFocalPoint;
  Offset _previousOffset;
  Offset _offset;
  bool _scaleEnable;
  bool _doubleTapEnable;
  Offset _position;
  File _image;

  @override
  void initState() {
    _zoom = 1.0;
    _previousZoom = null;
    _offset = Offset.zero;
    _scaleEnable = true;
    _doubleTapEnable = true;
    _position = widget.position;
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Draggable(
          child: new Container(
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              width: 360.0,
              height: 530.0,
              child: new GestureDetector(
                onScaleStart: _scaleEnable ? _handleScaleStart : null,
                onScaleUpdate: _scaleEnable ? _handleScaleUpdate : null,
                onScaleEnd: (ScaleEndDetails details) {
                  _previousZoom = null;
                },
                onDoubleTap: _doubleTapEnable ? _handleScaleReset : null,
                child: new Transform(
                  transform: new Matrix4.diagonal3(
                      new v3.Vector3(_zoom, _zoom, _zoom)),
                  alignment: FractionalOffset.center,
                  child: new Image.file(_image),
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              _position = offset;
            });
          },
          feedback: Container(
            width: 1.0,
            height: 1.0,
            child: new Image.file(_image),
          )),
    );
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
      _position = Offset.zero;
    });
  }
}
