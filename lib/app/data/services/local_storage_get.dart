import 'dart:convert' as convert;

import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();

  static LocalStorage get = _singleton;

  LocalStorage._internal();

  GetStorage storage = GetStorage();

  write(String key, dynamic value) async {
    await storage.write(key, convert.jsonEncode(value));
  }

  dynamic read<S>(String key, {S Function(Map)? construct}) {
    String? value = storage.read(key);
    if (value == null) return;
    if (construct == null) return convert.jsonDecode(value);
    Map<String, dynamic> json = convert.jsonDecode(value);
    return construct(json);
  }

  remove(String key) {
    storage.remove(key);
  }

  removeAll() {
    throw UnimplementedError();
  }
}
