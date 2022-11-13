import 'dart:convert';

import 'dart:developer' as d;

import 'package:dio/dio.dart';

import '../../app/services/http_client.dart';
import '../modles/register.dart';
import '../modles/role_select.dart';
import '../modles/user.dart';

abstract class Http {
  Future<User> login({
    String? email,
    String? password,
  });

  Future<Register> register({
    String? selectedAvatarFile,
    String? userName,
    String? email,
    String? password,
    String? name,
    DateTime? birthDay,
    String? phoneNumber,
    RoleSelection? roleIds,
  });
}

class HttpImpl implements Http {
  final HttpClient httpClient;

  const HttpImpl({
    required this.httpClient,
  });

  @override
  Future<User> login({
    String? email,
    String? password,
  }) async {
    Map<String, dynamic> map = {};

    if (email != null) {
      map["email"] = email;
    }
    if (password != null) {
      map["password"] = password;
    }

    final rawData = json.encode(map);
    d.log("${rawData}");
    final response =
        await httpClient.post("/api/auth/login", body: rawData);

    return User.fromJson(json.decode(response));
  }

  @override
  Future<Register> register({
    String? selectedAvatarFile,
    String? userName,
    String? email,
    String? password,
    String? name,
    DateTime? birthDay,
    String? phoneNumber,
    RoleSelection? roleIds,
  }) async {
    Map<String, dynamic> map = {};

    if (selectedAvatarFile != null) {
      map["selectedAvatarFile"] = await MultipartFile.fromFile(selectedAvatarFile);
    }
    if (userName != null) {
      map["userName"] = userName;
    }
    if (email != null) {
      map["email"] = email;
    }
    if (password != null) {
      map["password"] = password;
    }
    if (name != null) {
      map["name"] = name;
    }
    if (birthDay != null) {
      map["birthDay"] = birthDay.toIso8601String();
    }
    if (phoneNumber != null) {
      map["phoneNumber"] = phoneNumber;
    }
    if (roleIds != null) {
      map["roleIds"] = roleIds.role;
    }

    final formData = FormData.fromMap(map);
    d.log("${formData}");
    final response =
    await httpClient.post("/api/users", body: formData);

    return Register.fromJson(json.decode(response));
  }
}
