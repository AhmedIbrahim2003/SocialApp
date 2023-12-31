class MessageModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderId,
    this.reciverId,
    this.dateTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    senderId = json!['senderId'];
    reciverId = json['reciverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderId'] = senderId;
    data['reciverId'] = reciverId;
    data['dateTime'] = dateTime;
    data['text'] = text;
    return data;
  }
}
