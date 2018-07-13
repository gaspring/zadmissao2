import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/views/confirmar-foto-view.dart';
import 'package:image/image.dart' as Im;
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:flutter/services.dart';

class CameraView extends StatefulWidget {
  DocumentoViewModel documento;
  String verso;

  CameraView({this.documento, this.verso});

  @override
  State<StatefulWidget> createState() => new _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  List<CameraDescription> _cameras;

  CameraController _cameraController;

  Widget _body;

  DialogUtils _dialog;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _body = new Container();
    _dialog = new DialogUtils(context);
  }

  void _initCamera() async {
    _cameras = await availableCameras();
    _cameraController =
        new CameraController(_cameras[0], ResolutionPreset.medium);

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _body = new Scaffold(
          body: new Column(
            children: <Widget>[
              new Flexible(child: new CameraPreview(_cameraController)),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new RaisedButton(
                      padding: const EdgeInsets.all(4.0),
                      color: Colors.amber,
                      onPressed: () => Navigator.pop(context),
                      child: new Text("Cancelar"),
                    ),
                  ),
                  new Expanded(
                    child: new RaisedButton(
                      padding: const EdgeInsets.all(4.0),
                      color: Colors.amber,
                      onPressed: _takePicture,
                      child: new Text("Tirar Foto"),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return _body;
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  // void _onTakePictureButtonPressed() {
  //    _dialog.showProgressDialog();

  //   _takePicture().then((filePath) async {
  //   var resizedFile = await compressImage(filePath);

  //   print(filePath);

  //   if (resizedFile != null) _dialog.dismiss();

  //   _transit(new ConfirmarFotoView(
  //       path: resizedFile, documento: widget.documento, verso: widget.verso));
  // });
  // }

  Future _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }

    _dialog.showProgressDialog();

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      return null;
    }

    var resizedFile = await compressImage(filePath);

    if (resizedFile != null) _dialog.dismiss();

    _transit(new ConfirmarFotoView(
        path: resizedFile, documento: widget.documento, verso: widget.verso));
  }

  Future<String> compressImage(String filePath) async {
    Im.Image image = Im.decodeImage(await new File(filePath).readAsBytes());
    Im.Image compressedImg = Im.copyResize(image, 1024);

    var resized = new File(filePath);

    var newImage =
        await resized.writeAsBytes(Im.encodeJpg(compressedImg, quality: 75));

    return newImage.path;
  }

  void _transit(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }
}
