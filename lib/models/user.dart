import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String city;
  final String? photoUrl;
  final DateTime createdAt;
  final int dayCount;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.city,
    this.photoUrl,
    required this.createdAt,
    this.dayCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'city': city,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'dayCount': dayCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      photoUrl: map['photoUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      dayCount: map['dayCount'] ?? 0,
    );
  }
}