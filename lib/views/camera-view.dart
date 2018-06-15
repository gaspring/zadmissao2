import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  List<CameraDescription> _cameras;

  CameraController _cameraController;

  Widget _body;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _body = new Container();
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
    return _body;
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
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

    return filePath;
  }
}
