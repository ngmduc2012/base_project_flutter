// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.id,
    this.userName,
    this.email,
    this.avatar,
    this.birthDay,
    this.phoneNumber,
    this.name,
    this.roles,
    this.permissions,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? userName;
  String? email;
  String? avatar;
  DateTime? birthDay;
  String? phoneNumber;
  String? name;
  List<Role>? roles;
  List<Permission>? permissions;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    avatar: json["avatar"],
    birthDay: DateTime.parse(json["birthDay"]),
    phoneNumber: json["phoneNumber"],
    name: json["name"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email": email,
    "avatar": avatar,
    "birthDay": birthDay!.toIso8601String(),
    "phoneNumber": phoneNumber,
    "name": name,
    "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
    "permissions": List<dynamic>.from(permissions!.map((x) => x.toJson())),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
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

class Role {
  Role({
    this.id,
    this.name,
    this.description,
    this.permissions,
  });

  String? id;
  String? name;
  String? description;
  List<Permission>? permissions;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "permissions": List<dynamic>.from(permissions!.map((x) => x.toJson())),
  };
}
