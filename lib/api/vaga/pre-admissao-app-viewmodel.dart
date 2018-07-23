class PreAdmissaoAppViewModel {
  String idPreAdmissaoApp;

  String nome;
  String cpf;

  String statusEndereco;
  String statusRG;
  String statusDocumentoCPF;
  String statusTituloDeEleitor;
  String statusCTPS;
  String statusPISPASEP;
  String statusReservista;
  String statusCNH;
  String statusRGVerso;
  String statusCTPSVerso;
  String statusContaBancaria;
  String statusContaBancariaVerso;
  String statusCertidaoNascimentoCasamento;
  String statusEscolaridade;
  String statusEscolaridadeVerso;
  String statusVacina;
  String statusVacina2;
  String statusVacina3;
  String statusCertificadoFormacaoVig;
  String statusCertificadoFormacaoVigVerso;
  String statusCertificadoReciclagemVig;
  String statusCertificadoReciclagemVigVerso;
  String statusCNVVig;
  String statusCNVVigVerso;
  String statusDRTVig;
  String statusDRTVigVerso;
  String status;
  String idVaga;
  String codigoVaga;
  String centroCusto;
  String numeroPosicao;
  String escalaPosicao;
  String horaInicioPosicao;
  String horaFimPosicao;
  String horaIntervaloPosicao;
  String cargo;
  String statusFichaRegistro;
  String statusFichaRegistroVerso;
  String statusFormularioVT;
  String statusSolicitacaoUniforme;

  PreAdmissaoAppViewModel(
      {this.idPreAdmissaoApp,
      this.nome,
      this.cpf,
      this.statusEndereco,
      this.statusRG,
      this.statusDocumentoCPF,
      this.statusTituloDeEleitor,
      this.statusCTPS,
      this.statusPISPASEP,
      this.statusReservista,
      this.statusCNH,
      this.statusRGVerso,
      this.statusCTPSVerso,
      this.statusContaBancaria,
      this.statusContaBancariaVerso,
      this.statusCertidaoNascimentoCasamento,
      this.statusEscolaridade,
      this.statusEscolaridadeVerso,
      this.statusVacina,
      this.statusVacina2,
      this.statusVacina3,
      this.statusCertificadoFormacaoVig,
      this.statusCertificadoFormacaoVigVerso,
      this.statusCertificadoReciclagemVig,
      this.statusCertificadoReciclagemVigVerso,
      this.statusCNVVig,
      this.statusCNVVigVerso,
      this.statusDRTVig,
      this.statusDRTVigVerso,
      this.status,
      this.idVaga,
      this.codigoVaga,
      this.centroCusto,
      this.numeroPosicao,
      this.escalaPosicao,
      this.horaInicioPosicao,
      this.horaFimPosicao,
      this.horaIntervaloPosicao,
      this.cargo,
      this.statusFormularioVT,
      this.statusSolicitacaoUniforme,
      this.statusFichaRegistro,
      this.statusFichaRegistroVerso});

  factory PreAdmissaoAppViewModel.fromJson(Map<String, dynamic> json) {
    return new PreAdmissaoAppViewModel(
      idPreAdmissaoApp: json['idPreAdmissaoApp'],
      nome: json['nome'],
      cpf: json['cpf'],
      statusEndereco: json['statusEndereco'],
      statusRG: json['statusRG'],
      statusDocumentoCPF: json['statusDocumentoCPF'],
      statusTituloDeEleitor: json['statusTituloDeEleitor'],
      statusCTPS: json['statusCTPS'],
      statusPISPASEP: json['statusPISPASEP'],
      statusReservista: json['statusReservista'],
      statusCNH: json['statusCNH'],
      statusRGVerso: json['statusRGVerso'],
      statusCTPSVerso: json['statusCTPSVerso'],
      statusContaBancaria: json['statusContaBancaria'],
      statusContaBancariaVerso: json['statusContaBancariaVerso'],
      statusCertidaoNascimentoCasamento:
          json['statusCertidaoNascimentoCasamento'],
      statusEscolaridade: json['statusEscolaridade'],
      statusEscolaridadeVerso: json['statusEscolaridadeVerso'],
      statusVacina: json['statusVacina'],
      statusVacina2: json['statusVacina2'],
      statusVacina3: json['statusVacina3'],
      statusCertificadoFormacaoVig: json['statusCertificadoFormacaoVig'],
      statusCertificadoFormacaoVigVerso:
          json['statusCertificadoFormacaoVigVerso'],
      statusCertificadoReciclagemVig: json['statusCertificadoReciclagemVig'],
      statusCertificadoReciclagemVigVerso:
          json['statusCertificadoReciclagemVigVerso'],
      statusCNVVig: json['statusCNVVig'],
      statusCNVVigVerso: json['statusCNVVigVerso'],
      statusDRTVig: json['statusDRTVig'],
      statusDRTVigVerso: json['statusDRTVigVerso'],
      status: json['status'],
      idVaga: json['idVaga'],
      codigoVaga: json['codigoVaga'],
      centroCusto: json['centroCusto'],
      numeroPosicao: json['numeroPosicao'],
      escalaPosicao: json['escalaPosicao'],
      horaInicioPosicao: json['horaInicioPosicao'],
      horaFimPosicao: json['horaFimPosicao'],
      horaIntervaloPosicao: json['horaIntervaloPosicao'],
      cargo: json['cargo'],
      statusFichaRegistro: json['StatusFichaRegistro'],
      statusFichaRegistroVerso: json['StatusFichaRegistroVerso'],
      statusFormularioVT: json['StatusFormularioVT'],
      statusSolicitacaoUniforme: json['StatusSolicitacaoUniforme'],
    );
  }
}
