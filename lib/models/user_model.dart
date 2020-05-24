import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String profileImageUrl;
  final String about;
  final bool isDataFilled;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.profileImageUrl,
    this.about,
    this.isDataFilled,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      profileImageUrl: doc['profileImageUrl'],
      about: doc['about'] ?? '',
      isDataFilled: doc['isDataFilled'],
    );
  }
}
