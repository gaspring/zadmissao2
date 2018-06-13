class LoginViewModel{
  String email;
  String password;

  LoginViewModel({this.email, this.password});

  Map toMap(){
    return {"email": email, "password": password};
  }
}