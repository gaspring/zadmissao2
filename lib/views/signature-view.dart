import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      home: new SignatureView(),
      debugShowCheckedModeBanner: false,
    ));

class SignatureView extends StatefulWidget {
  @override
  _SignatureState createState() => new _SignatureState();
}

class _SignatureState extends State<SignatureView> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox object = context.findRenderObject();
            Offset _localPosition =
                object.globalToLocal(details.globalPosition);

            setState(() {
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: new CustomPaint(
            painter: new Signature(
              points: _points,
            ),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
  }
}

class Signature extends CustomPainter {
  ValueChanged<Canvas> onSaveImage;
  List<Offset> points;
  PictureRecorder recorder = new PictureRecorder();
  Canvas _canvas;

  Signature({this.points, this.onSaveImage});

  @override
  void paint(Canvas canvas, Size size) {
    if (_canvas == null) _canvas = new Canvas(recorder);

    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
        _canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
