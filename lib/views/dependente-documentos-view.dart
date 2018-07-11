import 'package:flutter/material.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/preadmissao-app-dependente-viewmodel.dart';
import 'package:zadmissao/views/camera-view.dart';

class DependenteDocumentosView extends StatefulWidget {
  PreAdmissaoAppDependenteViewModel preAdmissaoAppDependente;

  DependenteDocumentosView({this.preAdmissaoAppDependente});

  @override
  State<StatefulWidget> createState() => new _DependenteDocumentoState();
}

class _DependenteDocumentoState extends State<DependenteDocumentosView> {
  List<DocumentoViewModel> _documentos;

  @override
  void initState() {
    _documentos = new List<DocumentoViewModel>();

    _documentos.add(new DocumentoViewModel(
        nome: "RG",
        key: "RGDEPENDENTE",
        temVerso: true,
        icon: _chooseIcons(widget.preAdmissaoAppDependente.statusRG),
        iconVerse:
            _chooseIcons(widget.preAdmissaoAppDependente.statusRGVerso)));
    _documentos.add(new DocumentoViewModel(
        nome: "CPF",
        key: "CPFDEPENDENTE",
        icon:
            _chooseIcons(widget.preAdmissaoAppDependente.statusDocumentoCPF)));
    _documentos.add(new DocumentoViewModel(
        nome: "Certidão de nascimento",
        key: "NASCIMENTODEPENDENTE",
        icon: _chooseIcons(
            widget.preAdmissaoAppDependente.statusCertidaoNascimento)));
    _documentos.add(new DocumentoViewModel(
        nome: "Frequência escolar",
        key: "FREQUENCIAESCOLARDEPENDENTE",
        icon: _chooseIcons(
            widget.preAdmissaoAppDependente.statusFrequenciaEscolar)));
    _documentos.add(new DocumentoViewModel(
        nome: "Vacina",
        key: "VACINADEPENDENTE",
        icon: _chooseIcons(widget.preAdmissaoAppDependente.statusVacina)));
    _documentos.add(new DocumentoViewModel(
        nome: "Vacina 2",
        key: "VACINA2DEPENDENTE",
        icon: _chooseIcons(widget.preAdmissaoAppDependente.statusVacina2)));
    _documentos.add(new DocumentoViewModel(
        nome: "Vacina 3",
        key: "VACINA3DEPENDENTE",
        icon: _chooseIcons(widget.preAdmissaoAppDependente.statusVacina3)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Documentos"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: _buildDocumentos(),
      ),
    );
  }

  Widget _buildDocumentos() {
    return new ListView.builder(
        shrinkWrap: true,
        itemCount: _documentos.length,
        itemBuilder: (context, index) {
          var documento = _documentos[index];
          documento.idPreAdmissaoApp =
              widget.preAdmissaoAppDependente.idPreAdmissaoAppDependente;
          documento.dependenteOuAdmissao = "D";

          return new ListTile(
              onTap: () => _dialogEscolherLadoFoto(documento),
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
          buildIconColumn(doc.icon, 'Frente'),
          buildIconColumn(doc.iconVerse, 'Verso')
        ],
      ),
    );
  }

  Column buildIconColumn(Icon icon, String label) {
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

  _abrirCamera(DocumentoViewModel documento, String isVerse) async {
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
}
