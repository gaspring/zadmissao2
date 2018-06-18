class DocumentoViewModel {
  String nome;
  String key;
  String idPreAdmissaoApp;

  DocumentoViewModel({this.nome: "", this.key: "", this.idPreAdmissaoApp: ""});

  factory DocumentoViewModel.fromJson(Map<String, dynamic> json) {
    return new DocumentoViewModel(idPreAdmissaoApp: json['idPreAdmissaoApp']);
  }
}
