class PostData {
  String? image;
  String? name;
  String? uId;
  String? dateTime;
  String? text;
  String? postImage;

  PostData({
    this.image,
    this.name,
    this.uId,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostData.fromJson(Map<String, dynamic>? json) {
    image = json!['image'];
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['uId'] = uId;
    data['dateTime'] = dateTime;
    data['text'] = text;
    data['postImage'] = postImage;
    return data;
  }
}
