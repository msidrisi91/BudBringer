//chats('id','uid', 'isGrp', 'name', 'about', 'phone_number', 'display_image_path_or_link', 'last_msg_id', 'last_seen')
class ChatModel {
  String id;
  String uid;
  bool isGrp;
  String about;
  String phoneNumber;
  String dp; // 'display_image_path_or_link'
  String lastMsgId;
  ChatModel({
    this.id,
    this.uid,
    this.isGrp,
    this.about,
    this.phoneNumber,
    this.dp,
    this.lastMsgId,
  });

  factory ChatModel.fromMapObject(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      uid: map['uid'],
      isGrp: map['isGrp'],
      about: map['about'],
      phoneNumber: map['phoneNumber'],
      dp: map['dp'],
      lastMsgId: map['lastMsgId'],
    );
  }
}
