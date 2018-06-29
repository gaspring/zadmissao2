import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:zadmissao/api/file/atualizar-documento-preadmissao-input.dart';
import 'package:zadmissao/settings/api-settings.dart';

class FileService {
  String _URL = "${ApiSettings.ENDPOINT}/vaga";

  Future uploadFile(AtualizarDocumentoPreAdmissaoInput input, File file, String tipo) async {
    try {
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      var length = await file.length();
      var uri = Uri.parse("$_URL/${_chooseURL(tipo)}/${input.idPreAdmissao}/${input.documento}");

      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(file.path), contentType: new MediaType("image", "png"));

      request.files.add(multipartFile);

      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } catch (e) {
      return null;
    }
  }

  String _chooseURL(String tipo){
    switch(tipo){
      case "A":
        return "atualizar-pre-admissao-app";
      case "D":
        return "atualizar-pre-admissao-app-dependente";
        default:
          return "";
    }
  }
}
