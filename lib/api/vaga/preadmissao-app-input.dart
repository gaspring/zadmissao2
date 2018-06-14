class PreAdmissaoAppInput {
  String idVaga;
  String CPF;
  String idUsuarioCriacao;

  PreAdmissaoAppInput({this.idVaga, this.CPF, this.idUsuarioCriacao});

  Map toMap() {
    return {
      "idVaga": this.idVaga,
      "CPF": this.CPF,
      "idUsuarioCriacao": this.idUsuarioCriacao
    };
  }
}
