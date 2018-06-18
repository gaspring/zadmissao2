class AtualizarDocumentoPreAdmissaoInput{
  String idPreAdmissao;
  String documento;

  AtualizarDocumentoPreAdmissaoInput({this.idPreAdmissao, this.documento});

  Map toMap(){
    return { "idPreAdmissao": this.idPreAdmissao, "documento": this.documento };
  }
}