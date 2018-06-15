import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/views/camera-view.dart';

class CriarPreAdmissaoView extends StatefulWidget {
  final VagaViewModel vagaViewModel;

  CriarPreAdmissaoView({this.vagaViewModel});

  @override
  State<StatefulWidget> createState() => new _CriarPreAdmissaoState();
}

class _CriarPreAdmissaoState extends State<CriarPreAdmissaoView> {
  TextEditingController _textEditingControllerCPF;

  List<DocumentoViewModel> _documentos;

  @override
  void initState() {
    _textEditingControllerCPF = new TextEditingController();
    _documentos = new List<DocumentoViewModel>();

    _documentos.add(new DocumentoViewModel(nome: "RG"));
    _documentos.add(new DocumentoViewModel(nome: "CPF"));
    _documentos.add(new DocumentoViewModel(nome: "Título de eleitor"));
    _documentos.add(new DocumentoViewModel(nome: "CTPS"));
    _documentos.add(new DocumentoViewModel(nome: "PIS/PASEP"));
    _documentos.add(new DocumentoViewModel(nome: "Reservista"));
    _documentos.add(new DocumentoViewModel(nome: "CNH"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: new Container(),
          title: new Text("Criar PreAdmissão"),
        ),
        body: new Container(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[_buildDetalhes(), _buildDocumentos()],
          ),
        ));
  }

  Widget _buildDetalhes() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text("${widget.vagaViewModel.cpf}"),
          ),
          new Container(
            child: new Text("${widget.vagaViewModel.codigoVaga}"),
          ),
          new Container(
            child: new Text("${widget.vagaViewModel.cargo}"),
          ),
          new Container(
            padding: const EdgeInsets.all(2.0),
            child: new Text(
                "(${widget.vagaViewModel.numeroPosicao}) ${widget.vagaViewModel
                    .escalaPosicao}, ${widget.vagaViewModel
                    .horaInicioPosicao} - ${widget.vagaViewModel
                    .horaFimPosicao} (${widget.vagaViewModel
                    .horaIntervaloPosicao})"),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentos() {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: _documentos.length,
        itemBuilder: (context, index) {
          var documento = _documentos[index];

          return new ListTile(
              onTap: _dialogEscolherLadoFoto,
              title: new Text(documento.nome),
              trailing: new Icon(Icons.camera_alt));
        });
  }

  void _dialogEscolherLadoFoto() {
    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Tirar foto"),
              content: new Container(
                padding: const EdgeInsets.all(4.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      onTap: _abrirCamera,
                      title: new Text("Frente"),
                      trailing: new Icon(Icons.add_a_photo),
                    ),
                    new ListTile(
                      onTap: _abrirCamera,
                      title: new Text("Verso"),
                      trailing: new Icon(Icons.add_a_photo),
                    )
                  ],
                ),
              ),
            ));
  }

  void _abrirCamera() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new CameraView()),
    );
  }
}
