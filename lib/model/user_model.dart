class UserModel {
  late String idLogin;
  late String idUser;
  late String idRole;
  late String username;
  late String password;
  Null roleStatus;

  UserModel(
      {
      required this.idLogin,
      required this.idUser,
      required this.idRole,
      required this.username,
      required this.password,
      this.roleStatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    idLogin = json['id_login'];
    idUser = json['Id_user'];
    idRole = json['Id_role'];
    username = json['username'];
    password = json['password'];
    roleStatus = json['role_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   data['id_login'] = this.idLogin;
    data['Id_user'] = this.idUser;
    data['Id_role'] = this.idRole;
    data['username'] = this.username;
    data['password'] = this.password;
    data['role_status'] = this.roleStatus;
    return data;
  }
}
