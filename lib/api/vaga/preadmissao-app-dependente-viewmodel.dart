class PreAdmissaoAppDependenteViewModel{
  String idPreAdmissaoApp;
  String idPreAdmissaoAppDependente;
  String nome;
  String grauParentesco;

  PreAdmissaoAppDependenteViewModel({this.idPreAdmissaoApp, this.idPreAdmissaoAppDependente, this.nome, this.grauParentesco});

  factory PreAdmissaoAppDependenteViewModel.fromJson(Map<String, dynamic> json){
    return new PreAdmissaoAppDependenteViewModel(
      idPreAdmissaoApp: json['idPreAdmissaoApp'],
      idPreAdmissaoAppDependente: json['idPreAdmissaoAppDependente'],
      nome: json['nome'],
      grauParentesco: json['grauParentesco']
    );
  }
}