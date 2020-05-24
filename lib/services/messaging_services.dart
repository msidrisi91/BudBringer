import 'package:budbringer/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static send(String uid, int type, value, {bool isGrp = false}) {
    final docRef = usersRef
        .document(uid)
        .collection('messages')
        .document(DateTime.now().millisecondsSinceEpoch.toString());
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        docRef,
        {
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'value': value,
          'isGrp': isGrp,
          'read': false,
          'type': type,
          'uid': uid,
        },
      );
    });
  }

  static getMsgStreamFromFirebase(String myUid) {
    usersRef
        .document(myUid)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((event) {
      event.documents.forEach((element) {
        element.data;
      });
    });
  }
}
