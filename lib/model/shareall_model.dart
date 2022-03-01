class AllShare {
  late String fullname;
  late String numberShares;
  late String sumDividend;

  AllShare(
      {required this.fullname,
      required this.numberShares,
      required this.sumDividend});

  AllShare.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    numberShares = json['number_shares'];
    sumDividend = json['sum_dividend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['number_shares'] = this.numberShares;
    data['sum_dividend'] = this.sumDividend;
    return data;
  }
}
