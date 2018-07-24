import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zadmissao/api/login/login-viewmodel.dart';
import 'package:zadmissao/api/login/token-viewmodel.dart';
import 'package:zadmissao/settings/api-settings.dart';
import 'package:zadmissao/utils/dialog-utils.dart';
import 'package:flutter/material.dart';

class LoginService {
  Map<String, String> headers;
  String _URL;
  DialogUtils _dialog;

  LoginService() {
    _URL = "${ApiSettings.ENDPOINT_NO_API}/Account";
    headers = new Map();

    headers[HttpHeaders.CONTENT_TYPE] = "application/json";
  }

  Future<TokenViewModel> login(LoginViewModel vm, BuildContext context) async {
    var url = "$_URL/CreateToken";

    try {
      var response = await http
          .post(url, headers: headers, body: json.encode(vm.toMap()))
          .timeout(new Duration(seconds: 10), onTimeout: () {
        return null;
      });
      var responseJson = json.decode(response.body);

      return new TokenViewModel.fromJson(responseJson);
    } catch (e) {
      return null;
    }
  }
}
