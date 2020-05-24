// String readTimestamp(int timestamp) {
//     var now = new DateTime.now();
//     var format = new DateFormat('HH:mm a');
//     var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
//     var diff = date.difference(now);
//     var time = '';
//     if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
//       time = format.format(date);
//     } else {
//       if (diff.inDays == 1) {
//         time = diff.inDays.toString() + 'DAY AGO';
//       } else {
//         time = diff.inDays.toString() + 'DAYS AGO';
//       }
//     }
//     return time;
//   }
//messages('chat_id','from','type','text','link','timestamp')

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String chatId;
  String from;
  String type;
  String text;
  String link;
  Timestamp timestamp;

  MessageModel({
    this.chatId,
    this.from,
    this.type,
    this.text,
    this.link,
    this.timestamp,
  });

  factory MessageModel.fromDoc(DocumentSnapshot doc) {
    return MessageModel(
      chatId: doc['chatId'],
      from: doc['from'],
      type: doc['type'],
      text: doc['text'],
      link: doc['link'],
      timestamp: doc['timestamp'],
    );
  }

  factory MessageModel.fromMapObject(Map<String, dynamic> map) {
    return MessageModel(
      chatId: map['chatId'],
      from: map['from'],
      type: map['type'],
      text: map['text'],
      link: map['link'],
      timestamp: map['timestamp'],
    );
  }
}
