import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
}
