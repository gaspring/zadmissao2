import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/pre-admissao-app-viewmodel.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/views/dependente-view.dart';
import 'package:zadmissao/views/camera-view.dart';

class CriarPreAdmissaoView extends StatefulWidget {
  final VagaViewModel vagaViewModel;
  final PreAdmissaoAppViewModel preAdmissaoAppViewModel;

  CriarPreAdmissaoView({this.vagaViewModel, this.preAdmissaoAppViewModel});

  @override
  State<StatefulWidget> createState() => new _CriarPreAdmissaoState();
}

class _CriarPreAdmissaoState extends State<CriarPreAdmissaoView> {
  List<DocumentoViewModel> _documentos;

  @override
  void initState() {
    _documentos = new List<DocumentoViewModel>();

    _documentos.add(new DocumentoViewModel(
        nome: "Dependentes", key: "DEPENDENTES", icon: new Icon(Icons.group)));
    _documentos.add(new DocumentoViewModel(
        nome: "RG",
        key: "RG",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusRG)));
    _documentos.add(new DocumentoViewModel(
        nome: "CPF",
        key: "CPF",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusDocumentoCPF)));
    _documentos.add(new DocumentoViewModel(
        nome: "Título de eleitor",
        key: "TITULODEELEITOR",
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusTituloDeEleitor)));
    _documentos.add(new DocumentoViewModel(
        nome: "CTPS",
        key: "CTPS",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusCTPS)));
    _documentos.add(new DocumentoViewModel(
        nome: "PIS/PASEP",
        key: "PISPASEP",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusPISPASEP)));
    _documentos.add(new DocumentoViewModel(
        nome: "Reservista",
        key: "RESERVISTA",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusReservista)));
    _documentos.add(new DocumentoViewModel(
        nome: "CNH",
        key: "CNH",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusCNH)));
    _documentos.add(new DocumentoViewModel(
        nome: "Conta bancária",
        key: "CONTABANCARIA",
        temVerso: true,
        icon:
            _chooseIcons(widget.preAdmissaoAppViewModel.statusContaBancaria)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certidão de nascimento ou casamento",
        key: "CERTIDAONASCIMENTOCASAMENTO",
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertidaoNascimentoCasamento)));
    _documentos.add(new DocumentoViewModel(
        nome: "Escolaridade",
        key: "ESCOLARIDADE",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusEscolaridade)));
    _documentos.add(new DocumentoViewModel(
        nome: "Carteirinha de vacina",
        key: "VACINA",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusVacina)));
    _documentos.add(new DocumentoViewModel(
        nome: "Carteirinha de vacina 2",
        key: "VACINA2",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusVacina2)));
    _documentos.add(new DocumentoViewModel(
        nome: "Carteirinha de vacina 3",
        key: "VACINA3",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusVacina3)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado de formação de vigilante",
        key: "CERTIFICADOFORMACAOVIG",
        temVerso: true,
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertificadoFormacaoVig)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado nacional de vigilante",
        key: "CNVVIG",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusCNVVig)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado de reciclagem",
        key: "CERTIFICADORECICLAGEMVIG",
        temVerso: true,
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertificadoReciclagemVig)));
    _documentos.add(new DocumentoViewModel(
        nome: "DRT",
        key: "DRTVIG",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusDRTVig)));

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
        body: new Container(child: _buildDocumentos()));
  }

  Widget _buildDetalhes() {
    return new Container(
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
              onTap: () => _checkItemClick(documento),
              title: new Text(documento.nome),
              trailing: documento.icon);
        });
  }

  void _checkItemClick(DocumentoViewModel documento) {
    if (documento.key == "DEPENDENTES") {
      _transit(new DependenteView(documento: documento));
    } else {
      _dialogEscolherLadoFoto(documento);
    }
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

  _abrirCamera(DocumentoViewModel documento) async {
    final isChecked = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CameraView(documento: documento)),
    );

    if (isChecked == "doneSendingPhotoToServer") {
      _documentos.where((doc) => doc.key == documento.key).first.icon =
          new Icon(Icons.done, color: Colors.green);
    }
  }

  void _openInfoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Informação"),
              content: _buildDetalhes(),
            ));
  }

  Icon _chooseIcons(String status) {
    if (status == null) status = "";

    var icon = new Icon(Icons.camera_alt);

    switch (status.toUpperCase()) {
      case "ENVIADO":
        icon = new Icon(Icons.done, color: Colors.green);
        break;
      case "VALIDADO":
        icon = new Icon(Icons.done_all, color: Colors.green);
        break;
      case "REVER IMAGEM":
        icon = new Icon(Icons.thumb_down, color: Colors.red);
        break;
    }

    return icon;
  }

  void _transit(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }
}
