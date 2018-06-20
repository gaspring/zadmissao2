class DocumentoViewModel {
  String nome;
  String key;
  String idPreAdmissaoApp;
  bool temVerso;

  DocumentoViewModel({this.nome: "", this.key: "", this.idPreAdmissaoApp: "", this.temVerso: false});

  factory DocumentoViewModel.fromJson(Map<String, dynamic> json) {
    return new DocumentoViewModel(idPreAdmissaoApp: json['idPreAdmissaoApp']);
  }
}
