class UserModel {
  Message? message;

  UserModel({this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? firstName;
  String? lastName;
  String? gender;
  String? password;
  String? type;
  String? address;
  String? email;
  String? contactNo;
  String? imageUrl;
  int? iV;

  Message(
      {this.sId,
      this.firstName,
      this.lastName,
      this.gender,
      this.password,
      this.type,
      this.address,
      this.email,
      this.contactNo,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    password = json['password'];
    type = json['type'];
    address = json['address'];
    email = json['email'];
    contactNo = json['contactNo'];
    imageUrl = json['imageUrl'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['password'] = this.password;
    data['type'] = this.type;
    data['address'] = this.address;
    data['email'] = this.email;
    data['contactNo'] = this.contactNo;
    data['imageUrl'] = this.imageUrl;
    data['__v'] = this.iV;
    return data;
  }
}
