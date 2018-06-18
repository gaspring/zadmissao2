import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zadmissao/api/vaga/documento-viewmodel.dart';
import 'package:zadmissao/api/vaga/preadmissao-app-input.dart';
import 'package:zadmissao/api/vaga/vaga-viewmodel.dart';
import 'package:zadmissao/settings/api-settings.dart';

class VagaService {
  String _URL = "${ApiSettings.ENDPOINT}/vaga";
  Map<String, String> _header;

  VagaService() {
    _header = new Map<String, String>();

    _header[HttpHeaders.CONTENT_TYPE] = "application/json";
  }

  Future<List<VagaViewModel>> listarVagas() async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var idUsuario = preferences.get(ApiSettings.ID_USER);

      _header[HttpHeaders.AUTHORIZATION] =
          "Bearer ${preferences.get(ApiSettings.API_TOKEN)}";

      var url = "$_URL/listar-vagas-usuario/$idUsuario";

      var response = await http.get(url, headers: _header);
      var responseJson = json.decode(response.body);

      var l = (responseJson as List).map((x) => new VagaViewModel.fromJson(x));

      return l.toList();
    } catch (e) {
      return null;
    }
  }

  Future<DocumentoViewModel> criarPreAdmissao(PreAdmissaoAppInput input) async {
    try {
      var url = "$_URL/criar-pre-admissao-app";

      var preferences = await SharedPreferences.getInstance();
      var idUsuario = preferences.get(ApiSettings.ID_USER);

      _header[HttpHeaders.AUTHORIZATION] =
          "Bearer ${preferences.get(ApiSettings.API_TOKEN)}";

      input.idUsuarioCriacao = idUsuario;

      var response = await http.post(url,
          body: json.encode(input.toMap()), headers: _header);
      var responseJson = json.decode(response.body);

      return DocumentoViewModel.fromJson(responseJson);
    } catch (e) {
      return null;
    }
  }

  Future<List<VagaViewModel>> listarPreAdmissaoHistorico() async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var idUsuario = preferences.get(ApiSettings.ID_USER);

      var url = "$_URL/listar-pre-admissao-app/$idUsuario";

      _header[HttpHeaders.AUTHORIZATION] =
          "Bearer ${preferences.get(ApiSettings.API_TOKEN)}";

      var response = await http.get(url, headers: _header);
      var responseJson = json.decode(response.body);

      var l = (responseJson as List).map((x) => new VagaViewModel.fromJson(x));

      return l.toList();
    } catch (e) {
      return null;
    }
  }
}
