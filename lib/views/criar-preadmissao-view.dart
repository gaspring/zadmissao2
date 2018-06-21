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

    _documentos
        .add(new DocumentoViewModel(nome: "RG", key: "RG", temVerso: true));
    _documentos.add(new DocumentoViewModel(nome: "CPF", key: "CPF"));
    _documentos.add(new DocumentoViewModel(
        nome: "Título de eleitor", key: "TITULODEELEITOR"));
    _documentos
        .add(new DocumentoViewModel(nome: "CTPS", key: "CTPS", temVerso: true));
    _documentos.add(new DocumentoViewModel(nome: "PIS/PASEP", key: "PISPASEP"));
    _documentos
        .add(new DocumentoViewModel(nome: "Reservista", key: "RESERVISTA"));
    _documentos.add(new DocumentoViewModel(nome: "CNH", key: "CNH"));
    _documentos.add(new DocumentoViewModel(
        nome: "Conta bancária", key: "CONTABANCARIA", temVerso: true));
    _documentos.add(new DocumentoViewModel(
        nome: "Certidão de nascimento ou casamento",
        key: "CERTIDAONASCIMENTOCASAMENTO"));
    _documentos.add(new DocumentoViewModel(
        nome: "Escolaridade", key: "ESCOLARIDADE", temVerso: true));
    _documentos.add(
        new DocumentoViewModel(nome: "Carteirinha de vacina", key: "VACINA"));
    _documentos.add(new DocumentoViewModel(
        nome: "Carteirinha de vacina 2", key: "VACINA2"));
    _documentos.add(new DocumentoViewModel(
        nome: "Carteirinha de vacina 3", key: "VACINA3"));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado de formação de vigilante",
        key: "CERTIFICADOFORMACAOVIG",
        temVerso: true));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado nacional de vigilante",
        key: "CNVVIG",
        temVerso: true));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado de reciclagem",
        key: "CERTIFICADORECICLAGEMVIG",
        temVerso: true));
    _documentos.add(
        new DocumentoViewModel(nome: "DRT", key: "DRTVIG", temVerso: true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("${widget.vagaViewModel.codigoVaga}"),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.info), onPressed: _openInfoDialog),
            ]),
        body: _buildDocumentos());
  }

  Widget _buildDetalhes() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              padding: const EdgeInsets.all(4.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(
                    "CPF: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  new Expanded(child: new Text("${widget.vagaViewModel.cpf}"))
                ],
              )),
          new Container(
              padding: const EdgeInsets.all(4.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(
                    "Cód. Vaga: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  new Expanded(
                    child: new Text("${widget.vagaViewModel.codigoVaga}"),
                  )
                ],
              )),
          new Container(
              padding: const EdgeInsets.all(4.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(
                    "Cargo: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  new Expanded(
                    child: new Text("${widget.vagaViewModel.cargo}"),
                  )
                ],
              )),
          new Container(
              padding: const EdgeInsets.all(4.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Text(
                    "Posição",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  new Expanded(
                    child: new Text(
                        "(${widget.vagaViewModel.numeroPosicao}) ${widget
                            .vagaViewModel
                            .escalaPosicao}, ${widget.vagaViewModel
                            .horaInicioPosicao} - ${widget.vagaViewModel
                            .horaFimPosicao} (${widget.vagaViewModel
                            .horaIntervaloPosicao})"),
                  )
                ],
              )),
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
          documento.idPreAdmissaoApp = widget.vagaViewModel.idPreAdmissao;

          return new ListTile(
              onTap: () => _dialogEscolherLadoFoto(documento),
              title: new Text(documento.nome),
              trailing: new Icon(Icons.camera_alt));
        });
  }

  void _dialogEscolherLadoFoto(DocumentoViewModel documento) {
    var fotos = [
      new ListTile(
        onTap: () => _abrirCamera(documento),
        title: new Text("Frente"),
        trailing: new Icon(Icons.add_a_photo),
      )
    ];

    if (documento.temVerso)
      fotos.add(new ListTile(
        onTap: () {
          documento.key = "${documento.key}VERSO";
          _abrirCamera(documento);
        },
        title: new Text("Verso"),
        trailing: new Icon(Icons.add_a_photo),
      ));

    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Tirar foto"),
              content: new Container(
                padding: const EdgeInsets.all(4.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: fotos,
                ),
              ),
            ));
  }

  void _abrirCamera(DocumentoViewModel documento) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CameraView(documento: documento)),
    );
  }

  void _openInfoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Informação"),
              content: _buildDetalhes(),
            ));
  }
}
