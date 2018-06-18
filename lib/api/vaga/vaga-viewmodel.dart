class VagaViewModel {
  String idPreAdmissao;
  String idVaga;
  String codigoVaga;
  String centroCusto;
  String numeroPosicao;
  String escalaPosicao;
  String horaInicioPosicao;
  String horaFimPosicao;
  String horaIntervaloPosicao;
  String cargo;
  String cpf;

  VagaViewModel(
      {this.idVaga,
      this.codigoVaga,
      this.centroCusto,
      this.numeroPosicao,
      this.escalaPosicao,
      this.horaInicioPosicao,
      this.horaFimPosicao,
      this.horaIntervaloPosicao,
      this.cargo,
      this.idPreAdmissao});

  factory VagaViewModel.fromJson(Map<String, dynamic> json) {
    return new VagaViewModel(
        idVaga: json['idVaga'],
        codigoVaga: json['codigoVaga'],
        centroCusto: json['centroCusto'],
        numeroPosicao: json['numeroPosicao'],
        escalaPosicao: json['escalaPosicao'],
        horaInicioPosicao: json['horaInicioPosicao'],
        horaFimPosicao: json['horaFimPosicao'],
        horaIntervaloPosicao: json['horaIntervaloPosicao'],
        cargo: json['cargo']);
  }
}
