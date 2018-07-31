import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/views/confirmar-foto-view.dart';
import 'package:image/image.dart' as Im;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends StatefulWidget {
  final DocumentoViewModel documento;
  final String verso;

  CameraView({this.documento, this.verso});

  @override
  State<StatefulWidget> createState() => new _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  DocumentoViewModel _doc;
  String _verse;

  @override
  void initState() {
    super.initState();
    _doc = widget.documento;
    _verse = widget.verso;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_doc.nome + ' - ' + _verse),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text("Tire uma foto ou escolha uma foto da galeria",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 25.0)),
                      new RaisedButton(
                        child: new Text("Foto",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 22.0)),
                        color: new Color.fromRGBO(43, 186, 180, 1.0),
                        onPressed: _takePicture,
                      ),
                      new RaisedButton(
                        child: new Text("Galeria de imagens",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 22.0)),
                        color: new Color.fromRGBO(43, 186, 180, 1.0),
                        onPressed: _openGallery,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void _takePicture() async {
    File photo = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 2048.0);

    if (photo != null) {
      // var resizedPhoto = await compressImage(photo.path);
      // if (resizedPhoto != null)
      _transit(new ConfirmarFotoView(
          path: photo.path, documento: _doc, verso: _verse, camera: true));
    }
  }

  void _openGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      // var resized = await compressImage(img.path);
      // if (resized != null)
      _transit(new ConfirmarFotoView(
          path: img.path, documento: _doc, verso: _verse, camera: false));
    }
  }

  Future<String> compressImage(String filePath) async {
    Im.Image image = Im.decodeImage(await new File(filePath).readAsBytes());
    Im.Image compressedImg = Im.copyResize(image, 1024);

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures';
    await new Directory(dirPath).create(recursive: true);

    var resized = new File('$dirPath/${timestamp()}.jpg');

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
