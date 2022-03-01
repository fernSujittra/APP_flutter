class all_sumuser {
  late String aNum;
  late String aPrice;
  late String dPriceShares;
  late String totalPriceCost;
  late String profitSum;
  late String sumDividend;

  all_sumuser(
      {required this.aNum,
      required this.aPrice,
      required this.dPriceShares,
      required this.totalPriceCost,
      required this.profitSum,
      required this.sumDividend});

  all_sumuser.fromJson(Map<String, dynamic> json) {
    aNum = json['a_num'];
    aPrice = json['a_price'];
    dPriceShares = json['d_price_shares'];
    totalPriceCost = json['total_price_cost'];
    profitSum = json['profit_sum'];
    sumDividend = json['sum_dividend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a_num'] = this.aNum;
    data['a_price'] = this.aPrice;
    data['d_price_shares'] = this.dPriceShares;
    data['total_price_cost'] = this.totalPriceCost;
    data['profit_sum'] = this.profitSum;
    data['sum_dividend'] = this.sumDividend;
    return data;
  }
}
