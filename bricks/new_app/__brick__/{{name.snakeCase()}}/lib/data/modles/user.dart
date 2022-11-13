// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../app/utils/image.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.userName,
    this.name,
    this.avatar,
    this.email,
    this.accessToken,
    this.refreshToken,
    this.permissions,
  });

  String? userName;
  String? name;
  Uint8List? avatar;
  String? email;
  String? accessToken;
  String? refreshToken;
  List<Permission>? permissions;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userName: json["userName"],
    name: json["name"],
    avatar: ImageHelper.base64Decode(json["avatar"].replaceAll("\n", "")),
    email: json["email"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "name": name,
    "avatar": avatar == null ? "" : base64Encode(avatar!) ,
    "email": email,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "permissions": List<dynamic>.from(permissions!.map((x) => x.toJson())),
  };
}

class Permission {
  Permission({
    this.name,
    this.action,
    this.subject,
    this.fields,
    this.conditions,
  });

  String? name;
  String? action;
  String? subject;
  List<String>? fields;
  Conditions? conditions;

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    name: json["name"],
    action: json["action"],
    subject: json["subject"],
    fields: List<String>.from(json["fields"].map((x) => x)),
    conditions: Conditions.fromJson(json["conditions"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "action": action,
    "subject": subject,
    "fields": List<dynamic>.from(fields!.map((x) => x)),
    "conditions": conditions!.toJson(),
  };
}

class Conditions {
  Conditions();

  factory Conditions.fromJson(Map<String, dynamic> json) => Conditions(
  );

  Map<String, dynamic> toJson() => {
  };
}
