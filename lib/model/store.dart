class StoreModel {
  List<Message>? message;

  StoreModel({this.message});

  StoreModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? address;
  String? openHours;
  String? contactNo;
  String? imageUrl;
  String? catergory;
  String? owner;
  int? iV;

  Message(
      {this.sId,
      this.name,
      this.address,
      this.openHours,
      this.contactNo,
      this.imageUrl,
      this.catergory,
      this.owner,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
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
