class CardEntity {
  String? cardNumber;
  String? nameSurname;
  String? date;
  String? secCode;

  CardEntity({this.cardNumber, this.nameSurname, this.date, this.secCode});

  CardEntity.fromJson(Map<String, dynamic> json) {
    cardNumber = json['CardNumber'];
    nameSurname = json['NameSurname'];
    date = json['Date'];
    secCode = json['SecCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CardNumber'] = this.cardNumber;
    data['NameSurname'] = this.nameSurname;
    data['Date'] = this.date;
    data['SecCode'] = this.secCode;
    return data;
  }
}
