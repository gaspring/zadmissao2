class TokenViewModel{
  String token;
  String idUser;

  TokenViewModel({this.token, this.idUser});

  factory TokenViewModel.fromJson(Map<String, dynamic> json){
    return new TokenViewModel(token: json["token"], idUser: json["idUser"]);
  }
}