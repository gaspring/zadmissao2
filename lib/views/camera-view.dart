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

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  void _initCamera() async {
    _cameras = await availableCameras();
    _cameraController =
        new CameraController(_cameras[0], ResolutionPreset.medium);

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return new Container();
    }

    return new AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: new CameraPreview(_cameraController),
    );
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/zadmissao';
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
