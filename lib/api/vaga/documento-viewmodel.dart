import 'package:flutter/material.dart';

class DocumentoViewModel {
  String nome;
  String key;
  String idPreAdmissaoApp;
  bool temVerso;

  Icon icon;

  String dependenteOuAdmissao;

  DocumentoViewModel(
      {this.nome: "",
      this.key: "",
      this.idPreAdmissaoApp: "",
      this.temVerso: false,
      this.icon: const Icon(Icons.camera_alt),
      this.dependenteOuAdmissao: "A"});

  factory DocumentoViewModel.fromJson(Map<String, dynamic> json) {
    return new DocumentoViewModel(idPreAdmissaoApp: json['idPreAdmissaoApp']);
  }
}
