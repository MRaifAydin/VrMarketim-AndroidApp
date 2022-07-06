class UpdateUser {
  int? id;
  String? mail;
  String? password;
  String? name;
  String? surname;
  String? address;
  bool? isOkay;

  UpdateUser(
      {this.id,
      this.mail,
      this.password,
      this.name,
      this.surname,
      this.address});

  UpdateUser.fromJson(bool json) {
    isOkay = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Mail'] = this.mail;
    data['Password'] = this.password;
    data['Name'] = this.name;
    data['Surname'] = this.surname;
    data['Address'] = this.address;
    return data;
  }
}
