class SubscriptionModel {
  List<Message>? message;

  SubscriptionModel({this.message});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? sId;
  User? user;
  Store? store;
  int? iV;

  Message({this.sId, this.user, this.store, this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? gender;
  String? password;
  String? type;
  String? address;
  String? email;
  String? imageUrl;
  String? contactNo;
  int? iV;

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.gender,
      this.password,
      this.type,
      this.address,
      this.email,
      this.imageUrl,
      this.contactNo,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    password = json['password'];
    type = json['type'];
    address = json['address'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    contactNo = json['contactNo'];
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
    data['imageUrl'] = this.imageUrl;
    data['contactNo'] = this.contactNo;
    data['__v'] = this.iV;
    return data;
  }
}

class Store {
  String? sId;
  String? name;
  String? address;
  String? openHours;
  String? contactNo;
  String? imageUrl;
  String? catergory;
  String? owner;
  int? iV;

  Store(
      {this.sId,
      this.name,
      this.address,
      this.openHours,
      this.contactNo,
      this.imageUrl,
      this.catergory,
      this.owner,
      this.iV});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    openHours = json['openHours'];
    contactNo = json['contactNo'];
    imageUrl = json['imageUrl'];
    catergory = json['catergory'];
    owner = json['owner'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['openHours'] = this.openHours;
    data['contactNo'] = this.contactNo;
    data['imageUrl'] = this.imageUrl;
    data['catergory'] = this.catergory;
    data['owner'] = this.owner;
    data['__v'] = this.iV;
    return data;
  }
}
