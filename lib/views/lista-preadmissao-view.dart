import 'package:flutter/material.dart';
import 'package:zadmissao/api/vaga/vaga-service.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/utils/dialog-utils.dart';

class ListaPreAdmissaoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ListaPreAdmissaoState();
}

class _ListaPreAdmissaoState extends State<ListaPreAdmissaoView> {
  List<VagaViewModel> _lista;

  VagaService _vagaService;

  DialogUtils _dialog;

  @override
  void initState() {
    _lista = new List<VagaViewModel>();
    _vagaService = VagaService();
    _dialog = new DialogUtils(context);

    _listarHistorico();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _lista.length,
          itemBuilder: (context, index) {
            var p = _lista[index];

            return new Card(
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                child: new ListTile(
                  title: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                            child: new Text("(${p
                                    .numeroPosicao}) ${p
                                    .escalaPosicao}, ${p
                                    .horaInicioPosicao} - ${p
                                    .horaFimPosicao} (${p
                                    .horaIntervaloPosicao})"),
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

  void _listarHistorico() async {
    _dialog.showProgressDialog();
    var lista = await _vagaService.listarPreAdmissaoHistorico();
    _dialog.dismiss();

    if (lista != null) {
      setState(() {
        _lista = lista;
      });
    } else {
      _dialog.showAlertDialog("Ops...", "Tente novamente", "Ok", "");
    }
  }
}
