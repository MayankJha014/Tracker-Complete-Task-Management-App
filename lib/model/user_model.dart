// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String uid;
  final String email;
  final String password;
  final String profilePic;
  final List<String> follower;
  final List<String> following;
  UserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.follower,
    required this.following,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? email,
    String? password,
    String? profilePic,
    List<String>? follower,
    List<String>? following,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
      follower: follower ?? this.follower,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'follower': follower,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? "",
      uid: map['uid'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      profilePic: map['profilePic'] ?? "",
      follower: List<String>.from((map['follower'] ?? [])),
      following: List<String>.from((map['following'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, email: $email, password: $password, profilePic: $profilePic, follower: $follower, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.uid == uid &&
        other.email == email &&
        other.password == password &&
        other.profilePic == profilePic &&
        listEquals(other.follower, follower) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profilePic.hashCode ^
        follower.hashCode ^
        following.hashCode;
  }
}
