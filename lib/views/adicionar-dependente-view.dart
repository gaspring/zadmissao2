import 'package:flutter/material.dart';
import 'package:zadmissao/api/vaga/preadmissao-app-dependente-input.dart';
import 'package:zadmissao/api/vaga/vaga-service.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:zadmissao/views/dependente-documentos-view.dart';

class AdicionarDependenteView extends StatefulWidget {
  String idPreAdmissaoApp;

  AdicionarDependenteView({this.idPreAdmissaoApp});

  @override
  State<StatefulWidget> createState() => new _AdicionarDependenteViewState();
}

class _AdicionarDependenteViewState extends State<AdicionarDependenteView> {
  TextEditingController _textEditingControllerNome;
  String _grauParentesco;
  List<DropdownMenuItem<String>> _listaGrauParentesco;

  DialogUtils _dialog;

  VagaService _vagaService;

  @override
  void initState() {
    _textEditingControllerNome = new TextEditingController();
    _listaGrauParentesco = new List<DropdownMenuItem<String>>();

    _vagaService = new VagaService();
    _dialog = new DialogUtils(context);

    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "1-Filho (a) válido", child: new Text("1-Filho (a) válido")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "3-Filho (a) inválido",
        child: new Text("3-Filho (a) inválido")));
    _listaGrauParentesco.add(
        new DropdownMenuItem(value: "5-Cônjuge", child: new Text("5-Cônjuge")));
    _listaGrauParentesco
        .add(new DropdownMenuItem(value: "6-Pai", child: new Text("6-Pai")));
    _listaGrauParentesco
        .add(new DropdownMenuItem(value: "7-Mãe", child: new Text("7-Mãe")));
    _listaGrauParentesco.add(
        new DropdownMenuItem(value: "9-Sogra", child: new Text("9-Sogra")));
    _listaGrauParentesco.add(
        new DropdownMenuItem(value: "A-Avô(ó)", child: new Text("A-Avô(ó)")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "C-Companheiro(a)", child: new Text("C-Companheiro(a)")));
    _listaGrauParentesco.add(
        new DropdownMenuItem(value: "D-Enteado", child: new Text("D-Enteado")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "E-Excluído", child: new Text("E-Excluído")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "G-Ex-Cônjuge", child: new Text("G-Ex-Cônjuge")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "I-Irmã (o) válido", child: new Text("I-Irmã (o) válido")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "N-Irmã (o) inválido", child: new Text("N-Irmã (o) inválido")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "P-Ex-Companheiro(a)", child: new Text("P-Ex-Companheiro(a)")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "S-Ex-Sogro(a)", child: new Text("S-Ex-Sogro(a)")));
    _listaGrauParentesco.add(
        new DropdownMenuItem(value: "T-Neto(a)", child: new Text("T-Neto(a)")));
    _listaGrauParentesco.add(new DropdownMenuItem(
        value: "X-Ex-Enteado(a)", child: new Text("X-Ex-Enteado(a)")));

    _grauParentesco = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Adicionar Dependente"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildNome(),
            _buildListaGrauParentesco(),
            _buildButtonAdicionar()
          ],
        ),
      ),
    );
  }

  Widget _buildNome() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new TextField(
        maxLength: 50,
        keyboardType: TextInputType.text,
        decoration:
            const InputDecoration(hintText: "Qual o nome do dependente?"),
        controller: _textEditingControllerNome,
        autofocus: true,
      ),
    );
  }

  Widget _buildListaGrauParentesco() {
    return new Container(
      padding: const EdgeInsets.all(4.0),
      child: new DropdownButton(
          hint: new Text("Qual o grau de parentesco?"),
          iconSize: 0.0,
          value: _grauParentesco,
          items: _listaGrauParentesco,
          onChanged: _onDropDownChange),
    );
  }

  Widget _buildButtonAdicionar() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: new RaisedButton(
        color: Colors.amber,
        onPressed: _submit,
        child: new Text(
          "Adicionar",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _onDropDownChange(String selected) {
    setState(() {
      _grauParentesco = selected;
    });
  }

  bool _validarNome(String nome) {
    if (nome.trim().indexOf(" ") == -1) return false;

    return true;
  }

  bool _validarGraParentesco(String grauParentesco) {
    if (grauParentesco == null) return false;

    return true;
  }

  void _submit() async {
    var nome = _textEditingControllerNome.text;
    var grauParentesco = _grauParentesco;

    if (!_validarNome(nome)) {
      _dialog.showAlertDialog("Ops...", "Digite o nome e sobrenome", "ok");
    }

    if (!_validarGraParentesco(grauParentesco)) {
      _dialog.showAlertDialog("Ops...", "Selecione o grau de parentesco", "ok");
    }

    _dialog.showProgressDialog();
    var dependente = await _vagaService.adicionarDependente(
        new PreAdmissaoAppDependenteInput(
            idPreAdmissaoApp: widget.idPreAdmissaoApp,
            nome: nome,
            grauParentesco: grauParentesco));

    if (dependente != null) {
      _dialog.dismiss();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new DependenteDocumentosView(
                  preAdmissaoAppDependente: dependente, isNew: true)));
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "ok");
    }
  }
}
