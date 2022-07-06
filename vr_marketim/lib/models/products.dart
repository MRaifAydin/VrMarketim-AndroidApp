class Products {
  int? id;
  String? name;
  String? volume;
  int? pcs;
  String? description;

  Products({this.id, this.name, this.volume, this.pcs, this.description});

  Products.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    volume = json['volume'];
    pcs = json['pcs'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['volume'] = this.volume;
    data['pcs'] = this.pcs;
    data['description'] = this.description;
    return data;
  }
}
