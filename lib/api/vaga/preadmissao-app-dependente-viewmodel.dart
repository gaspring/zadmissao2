class PreAdmissaoAppDependenteViewModel {
  String idPreAdmissaoApp;
  String idPreAdmissaoAppDependente;
  String nome;
  String grauParentesco;
  String statusRG;
  String statusRGVerso;
  String statusDocumentoCPF;
  String statusCertidaoNascimento;
  String statusFrequenciaEscolar;
  String statusVacina;
  String statusVacina2;
  String statusVacina3;

  PreAdmissaoAppDependenteViewModel({this.idPreAdmissaoApp,
    this.idPreAdmissaoAppDependente,
    this.nome,
    this.grauParentesco,
    this.statusRG,
    this.statusVacina3,
    this.statusVacina2,
    this.statusVacina,
    this.statusDocumentoCPF,
    this.statusCertidaoNascimento,
    this.statusFrequenciaEscolar,
    this.statusRGVerso});

  factory PreAdmissaoAppDependenteViewModel.fromJson(
      Map<String, dynamic> json) {
    return new PreAdmissaoAppDependenteViewModel(
        idPreAdmissaoApp: json['idPreAdmissaoApp'],
        idPreAdmissaoAppDependente: json['idPreAdmissaoAppDependente'],
        nome: json['nome'],
        grauParentesco: json['grauParentesco'],
        statusCertidaoNascimento: json['statusCertidaoNascimento'],
        statusDocumentoCPF: json['statusDocumentoCPF'],
        statusFrequenciaEscolar: json['statusFrequenciaEscolar'],
        statusRG: json['statusRG'],
        statusRGVerso: json['statusRGVerso'],
        statusVacina2: json['statusVacina2'],
        statusVacina3: json['statusVacina3'],
        statusVacina: json['statusVacina']);
  }
}
