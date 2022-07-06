class basketEntity {
  int? id;
  int? accountId;
  String? products;

  basketEntity({this.id, this.accountId, this.products});

  basketEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountId'] = this.accountId;
    data['products'] = this.products;
    return data;
  }
}
