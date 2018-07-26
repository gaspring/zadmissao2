import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/pre-admissao-app-viewmodel.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/views/dependente-view.dart';
import 'package:zadmissao/views/camera-view.dart';
import 'package:zadmissao/views/main-view.dart';
import 'package:zadmissao/api/vaga/vaga-service.dart';

class CriarPreAdmissaoView extends StatefulWidget {
  final VagaViewModel vagaViewModel;
  final PreAdmissaoAppViewModel preAdmissaoAppViewModel;
  bool isNew;
  bool ePosProceso;

  CriarPreAdmissaoView(
      {this.vagaViewModel, this.preAdmissaoAppViewModel, this.isNew, this.ePosProceso: false});

  @override
  State<StatefulWidget> createState() => new _CriarPreAdmissaoState();
}

class _CriarPreAdmissaoState extends State<CriarPreAdmissaoView> {
  List<DocumentoViewModel> _documentos;
  VagaService _vagaService;

  @override
  void initState() {
    _documentos = new List<DocumentoViewModel>();
    _vagaService = new VagaService();

    _documentos.add(new DocumentoViewModel(
        nome: "Dependentes", key: "DEPENDENTES", icon: new Icon(Icons.group)));
    _documentos.add(new DocumentoViewModel(
        nome: "Solicitação de emprego",
        key: "SOLICITACAOEMPREGO",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusSolicitacaoEmprego),
        iconVerse: _chooseIcons(widget.preAdmissaoAppViewModel.statusSolicitacaoEmprego)));
    _documentos.add(new DocumentoViewModel(
        nome: "RG",
        key: "RG",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusRG),
        iconVerse: _chooseIcons(widget.preAdmissaoAppViewModel.statusRGVerso)));
    _documentos.add(new DocumentoViewModel(
        nome: "CPF",
        key: "CPF",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusDocumentoCPF)));
    _documentos.add(new DocumentoViewModel(
        nome: "Comprovante de residência",
        key: "ENDERECO",
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusRG)));
    _documentos.add(new DocumentoViewModel(
        nome: "Título de eleitor",
        key: "TITULODEELEITOR",
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusTituloDeEleitor)));
    _documentos.add(new DocumentoViewModel(
        nome: "CTPS",
        key: "CTPS",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusCTPS),
        iconVerse:
            _chooseIcons(widget.preAdmissaoAppViewModel.statusCTPSVerso)));
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
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusContaBancaria),
        iconVerse: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusContaBancariaVerso)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certidão de nascimento ou casamento",
        key: "CERTIDAONASCIMENTOCASAMENTO",
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertidaoNascimentoCasamento)));
    _documentos.add(new DocumentoViewModel(
        nome: "Escolaridade",
        key: "ESCOLARIDADE",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusEscolaridade),
        iconVerse: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusEscolaridadeVerso)));
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
        nome: "Ficha de registro",
        key: "FICHAREGISTRO",
        ePosProcesso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusFichaRegistro)));
    _documentos.add(new DocumentoViewModel(
        nome: "Solicitação de Vale Transporte",
        key: "FORMULARIOVT",
        ePosProcesso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusFormularioVT)));
    _documentos.add(new DocumentoViewModel(
        nome: "CTPS Assinada",
        key: "CTPSASSINADA",
        ePosProcesso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusCTPSAssinada)));
    _documentos.add(new DocumentoViewModel(
        nome: "Solicitação de uniforme",
        key: "SOLICITACAOUNIFORME",
        ePosProcesso: true,
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusSolicitacaoUniforme)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado de formação de vigilante",
        key: "CERTIFICADOFORMACAOVIG",
        temVerso: true,
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertificadoFormacaoVig),
        iconVerse: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertificadoFormacaoVigVerso)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado nacional de vigilante",
        key: "CNVVIG",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusCNVVig),
        iconVerse:
            _chooseIcons(widget.preAdmissaoAppViewModel.statusCNVVigVerso)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certificado de reciclagem",
        key: "CERTIFICADORECICLAGEMVIG",
        temVerso: true,
        icon: _chooseIcons(
            widget.preAdmissaoAppViewModel.statusCertificadoReciclagemVig),
        iconVerse: _chooseIcons(widget
            .preAdmissaoAppViewModel.statusCertificadoReciclagemVigVerso)));
    _documentos.add(new DocumentoViewModel(
        nome: "DRT",
        key: "DRTVIG",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppViewModel.statusDRTVig),
        iconVerse:
            _chooseIcons(widget.preAdmissaoAppViewModel.statusDRTVigVerso)));

    _documentos = _documentos.where((x) => x.ePosProcesso == widget.ePosProceso).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            leading: new IconButton(
                icon: new Icon(Icons.close), onPressed: _backToAnaliseView),
            title: new Text("${widget.vagaViewModel.codigoVaga}"),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.info), onPressed: _openInfoDialog),
            ]),
        body: new Container(
            child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildDetalhes(),
            new Expanded(child: _buildDocumentos())
          ],
        )));
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
              trailing: documento.temVerso == true
                  ? _hasTwoIcons(documento)
                  : documento.icon);
        });
  }

  Widget _hasTwoIcons(DocumentoViewModel doc) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildIconColumn(doc.icon, 'Frente'),
          _buildIconColumn(doc.iconVerse, 'Verso')
        ],
      ),
    );
  }

  Column _buildIconColumn(Icon icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Container(
          margin: const EdgeInsets.only(left: 3.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 10.0),
          ),
        )
      ],
    );
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
        onTap: () => _abrirCamera(documento, "Frente"),
        title: new Text("Frente"),
        trailing: new Icon(Icons.add_a_photo),
      )
    ];

    if (documento.temVerso)
      fotos.add(new ListTile(
        onTap: () {
          documento.key = "${documento.key}VERSO";
          _abrirCamera(documento, "Verso");
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

  _abrirCamera(documento, String isVerse) async {
    final isChecked = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
              new CameraView(documento: documento, verso: isVerse)),
    );

    if (isChecked == "doneSendingPhotoToServer-Frente") {
      _documentos.where((doc) => doc.key == documento.key).first.icon =
          new Icon(Icons.done, color: Colors.green);
    } else if (isChecked == "doneSendingPhotoToServer-Verso") {
      _documentos.where((doc) => doc.key == documento.key).first.iconVerse =
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

  void _backToAnaliseView() async {
    var finalizarProcesso = await _vagaService
        .finalizarPreAdmissaoApp(widget.vagaViewModel.idPreAdmissao);

    if (finalizarProcesso == 200) {
      if (widget.isNew != null && widget.isNew) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, MainView.ROUTE);
      } else {
        Navigator.pop(context);
      }
    }
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
