import 'package:flutter/material.dart';
import 'package:zadmissao/api/vaga/pre-admissao-app-viewmodel.dart';
import 'package:zadmissao/api/vaga/vaga-service.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:zadmissao/views/criar-preadmissao-view.dart';

class EmAnaliseView extends StatefulWidget {
  _EmAnaliseState _emAnaliseState = new _EmAnaliseState();

  @override
  State<StatefulWidget> createState() => _emAnaliseState;

  void openBusca() {
    _emAnaliseState._openBuscarEmAnalise();
  }
}

class _EmAnaliseState extends State<EmAnaliseView> {
  List<PreAdmissaoAppViewModel> _listaPreAdmissao;
  List<PreAdmissaoAppViewModel> _listaFiltroPreAdmissao;

  DialogUtils _dialog;
  VagaService _vagaService;
  BuildContext _context;

  @override
  void initState() {
    _context = context;
    _vagaService = new VagaService();
    _dialog = new DialogUtils(context);

    _listaPreAdmissao = new List<PreAdmissaoAppViewModel>();
    _listaFiltroPreAdmissao = new List<PreAdmissaoAppViewModel>();

    _listarPreAdmissaoEmAnalise();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _listaFiltroPreAdmissao.length,
          itemBuilder: (context, index) {
            var p = _listaFiltroPreAdmissao[index];

            return new Card(
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                child: new ListTile(
                  onTap: () {
                    var v = new VagaViewModel(
                        cargo: p.cargo,
                        centroCusto: p.centroCusto,
                        codigoVaga: p.codigoVaga,
                        escalaPosicao: p.escalaPosicao,
                        horaFimPosicao: p.horaFimPosicao,
                        horaInicioPosicao: p.horaInicioPosicao,
                        horaIntervaloPosicao: p.horaIntervaloPosicao,
                        idPreAdmissao: p.idPreAdmissaoApp,
                        idVaga: p.idVaga,
                        numeroPosicao: p.numeroPosicao,
                        cpf: p.cpf);

                    _transit(new CriarPreAdmissaoView(
                        vagaViewModel: v, preAdmissaoAppViewModel: p));
                  },
                  title: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text(
                              "${p.nome}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          new Container(
                            child: new Text(
                              "${p.codigoVaga}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          new Container(
                            child: new Text("${p.cargo}"),
                          ),
                          new Container(
                            child: new Text("${p.centroCusto}"),
                          ),
                          new Container(
                            padding: const EdgeInsets.all(2.0),
                            child: new Text(
                                "(${p.numeroPosicao}) ${p.escalaPosicao}, ${p.horaInicioPosicao} - ${p.horaFimPosicao} (${p.horaIntervaloPosicao})"),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _listarPreAdmissaoEmAnalise() async {
    _dialog.showProgressDialog();
    var lista = await _vagaService.listarPreAdmissaoEmAnalise();
    _dialog.dismiss();

    if (lista != null) {
      _listaPreAdmissao = lista;
      setState(() {
        _listaFiltroPreAdmissao = lista;
      });
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "Ok");
    }
  }

  void _transit(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }

  void _openBuscarEmAnalise() {
    TextEditingController textEditingControllerVaga =
        new TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Buscar Candidato"),
              content: new Container(
                padding: const EdgeInsets.all(4.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new TextField(
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      controller: textEditingControllerVaga,
                      decoration: const InputDecoration(
                          hintText: "Digite os dados"),
                    ),
                    new Row(
                      children: <Widget>[
                        new Expanded(
                            child: new RaisedButton(
                                child: new Text("Limpar"),
                                color: new Color.fromRGBO(43, 186, 180, 1.0),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _listaFiltroPreAdmissao = _listaPreAdmissao;
                                  });
                                })),
                        new Expanded(
                            child: new RaisedButton(
                                child: new Text("Pesquisar"),
                                color: new Color.fromRGBO(43, 186, 180, 1.0),
                                onPressed: () {
                                  _listaFiltroPreAdmissao = _listaPreAdmissao;

                                  var codigoVaga =
                                      textEditingControllerVaga.text;

                                  var filtro = _listaPreAdmissao
                                      .where((x) => x.codigoVaga
                                          .toUpperCase()
                                          .contains(codigoVaga.toUpperCase()))
                                      .toList();

                                  if (filtro.isEmpty)
                                    filtro = _listaPreAdmissao
                                        .where((x) => x.nome
                                            .toUpperCase()
                                            .contains(codigoVaga.toUpperCase()))
                                        .toList();

                                  if (filtro.isEmpty)
                                    filtro = _listaPreAdmissao
                                        .where((x) => x.cpf
                                            .toUpperCase()
                                            .replaceAll(".", "")
                                            .contains(codigoVaga
                                                .toUpperCase()
                                                .replaceAll(".", "")))
                                        .toList();

                                  Navigator.pop(context);

                                  if (filtro.isNotEmpty) {
                                    setState(() {
                                      _listaFiltroPreAdmissao = filtro;
                                    });
                                  } else {
                                    _dialog.showAlertDialog(
                                        "Ops...", "Não foi encontrado nenhum dado correspondente", "Ok");
                                  }
                                }))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
