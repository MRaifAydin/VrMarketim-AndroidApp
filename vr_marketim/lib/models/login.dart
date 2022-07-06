class Login {
  String? mail;
  String? password;
  bool? isOkay;

  Login({this.mail, this.password});

  Login.fromJson(bool json) {
    isOkay = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Mail'] = this.mail;
    data['Password'] = this.password;
    return data;
  }
}
