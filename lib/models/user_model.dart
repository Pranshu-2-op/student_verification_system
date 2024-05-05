// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String profilePic;
  final String uid;
  final String standard;
  final String phoneNumber;
  final String isAdminOf;
  final bool isMainAdmin;

  UserModel({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.standard,
    required this.phoneNumber,
    required this.isAdminOf,
    required this.isMainAdmin,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? uid,
    String? standard,
    String? phoneNumber,
    String? isAdminOf,
    bool? isMainAdmin,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      standard: standard ?? this.standard,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdminOf: isAdminOf ?? this.isAdminOf,
      isMainAdmin: isMainAdmin ?? this.isMainAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'standard': standard,
      'phoneNumber': phoneNumber,
      'isAdminOf': isAdminOf,
      'isMainAdmin': isMainAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      profilePic: map['profilePic'] as String? ?? '',
      uid: map['uid'] as String? ?? '',
      standard: map['standard'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      isAdminOf: map['isAdminOf'] as String? ?? '',
      isMainAdmin: map['isMainAdmin'] as bool? ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, profilePic: $profilePic, uid: $uid, standard: $standard, phoneNumber: $phoneNumber, isAdminOf: $isAdminOf, isMainAdmin: $isMainAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.standard == standard &&
        other.phoneNumber == phoneNumber &&
        other.isAdminOf == isAdminOf &&
        other.isMainAdmin == isMainAdmin;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        standard.hashCode ^
        phoneNumber.hashCode ^
        isAdminOf.hashCode ^
        isMainAdmin.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
