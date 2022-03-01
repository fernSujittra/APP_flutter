class showdata_user {
  late String idUser;
  late String idRole;
  late String username;
  late String password;
  late String fname;
  late String lname;
  late String cardId;
  late String birthDate;
  late String age;
  late String sex;
  late String phone;
  late String career;
  late String earnings;
  late String investment;
  late String idAddress;
  late String homeNumber;
  late String home;
  late String road;
  late String alley;
  late String tombonName;
  late String aumphurName;
  late String provinceName;
  late String postCode;

  showdata_user(
      {required this.idUser,
      required this.idRole,
      required this.username,
      required this.password,
      required this.fname,
      required this.lname,
      required this.cardId,
      required this.birthDate,
      required this.age,
      required this.sex,
      required this.phone,
      required this.career,
      required this.earnings,
      required this.investment,
      required this.idAddress,
      required this.homeNumber,
      required this.home,
      required this.road,
      required this.alley,
      required this.tombonName,
      required this.aumphurName,
      required this.provinceName,
      required this.postCode});

  showdata_user.fromJson(Map<String, dynamic> json) {
    idUser = json['Id_user'];
    idRole = json['Id_role'];
    username = json['username'];
    password = json['password'];
    fname = json['fname'];
    lname = json['lname'];
    cardId = json['card_id'];
    birthDate = json['birth_date'];
    age = json['age'];
    sex = json['sex'];
    phone = json['phone'];
    career = json['career'];
    earnings = json['earnings'];
    investment = json['Investment'];
    idAddress = json['id_address'];
    homeNumber = json['home_number'];
    home = json['home'];
    road = json['road'];
    alley = json['alley'];
    tombonName = json['tombon_name'];
    aumphurName = json['aumphur_name'];
    provinceName = json['province_name'];
    postCode = json['post_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id_user'] = this.idUser;
    data['Id_role'] = this.idRole;
    data['username'] = this.username;
    data['password'] = this.password;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['card_id'] = this.cardId;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['sex'] = this.sex;
    data['phone'] = this.phone;
    data['career'] = this.career;
    data['earnings'] = this.earnings;
    data['Investment'] = this.investment;
    data['id_address'] = this.idAddress;
    data['home_number'] = this.homeNumber;
    data['home'] = this.home;
    data['road'] = this.road;
    data['alley'] = this.alley;
    data['tombon_name'] = this.tombonName;
    data['aumphur_name'] = this.aumphurName;
    data['province_name'] = this.provinceName;
    data['post_code'] = this.postCode;
    return data;
  }
}
