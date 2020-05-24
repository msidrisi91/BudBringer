// participants('chat_id','id','uid','name','phoneNumber','pchat_id')
class ParticipantModel {
  String id;
  String uid;
  String chatId;
  String phoneNumber;
  String name;
  String pchatId;
  ParticipantModel({
    this.id,
    this.uid,
    this.chatId,
    this.phoneNumber,
    this.name,
    this.pchatId,
  });

  factory ParticipantModel.fromMapObject(Map<String, dynamic> map) {
    return ParticipantModel(
      id: map['id'],
      uid: map['uid'],
      chatId: map['chatId'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      pchatId: map['pchatId'],
    );
  }
}
