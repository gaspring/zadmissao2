class PreAdmissaoAppDependenteInput {
  String idPreAdmissaoApp;
  String nome;
  String grauParentesco;

  PreAdmissaoAppDependenteInput({this.idPreAdmissaoApp, this.nome, this.grauParentesco});

  Map toMap() {
    return {
      "idPreAdmissaoApp": this.idPreAdmissaoApp,
      "nome": this.nome,
      "grauParentesco": this.grauParentesco
    };
  }
}
