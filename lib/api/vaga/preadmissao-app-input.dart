class PreAdmissaoAppInput {
  String idVaga;
  String CPF;
  String idUsuarioCriacao;
  String nome;

  PreAdmissaoAppInput({this.idVaga, this.CPF, this.idUsuarioCriacao, this.nome});

  Map toMap() {
    return {
      "idVaga": this.idVaga,
      "CPF": this.CPF,
      "idUsuarioCriacao": this.idUsuarioCriacao,
      "nome": this.nome
    };
  }
}
