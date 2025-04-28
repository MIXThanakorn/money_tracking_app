class Money {
  String? moneyDetail;
  String? moneyDate;
  double? moneyInOut;
  int? moneyType;
  int? userID;

  Money(
      {this.moneyDetail,
      this.moneyDate,
      this.moneyInOut,
      this.moneyType,
      this.userID});

  Money.fromJson(Map<String, dynamic> json) {
    moneyDetail = json['moneyDetail'];
    moneyDate = json['moneyDate'];
    moneyInOut = (json['moneyInOut'] as num?)?.toDouble();
    moneyType = json['moneyType'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moneyDetail'] = this.moneyDetail;
    data['moneyDate'] = this.moneyDate;
    data['moneyInOut'] = this.moneyInOut;
    data['moneyType'] = this.moneyType;
    data['userID'] = this.userID;
    return data;
  }
}
