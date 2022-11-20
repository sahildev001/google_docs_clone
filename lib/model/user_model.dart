// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String profilePic;
  final String email;
  final String token;
  final String uid;

  UserModel(
      {required this.name,
      required this.profilePic,
      required this.email,
      required this.token,
      required this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'email': email,
      'token': token,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map["name"] ?? '') as String,
      profilePic: (map["profilePic"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      token: (map["token"] ?? '') as String,
      uid: (map["_id"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? email,
    String? token,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }
}
