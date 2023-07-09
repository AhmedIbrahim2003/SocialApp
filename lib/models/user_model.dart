// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserData {
  String? email;
  String? image;
  String? cover;
  bool? isVerified;
  String? name;
  String? phone;
  String? bio;
  String? uId;

  UserData({
    this.email,
    this.image,
    this.cover,
    this.isVerified,
    this.name,
    this.phone,
    this.bio,
    this.uId,
  });

  UserData.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    image = json['image'];
    cover = json['cover'];
    isVerified = json['isVerified'];
    name = json['name'];
    phone = json['phone'];
    bio = json['bio'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['image'] = image;
    data['cover'] = cover;
    data['isVerified'] = isVerified;
    data['name'] = name;
    data['phone'] = phone;
    data['bio'] = bio;
    data['uId'] = uId;
    return data;
  }

  bool checkIfExests(String? checkUId){
    if(uId != checkUId){
      return true;
    }else{
      return false;
    }
  }
}
