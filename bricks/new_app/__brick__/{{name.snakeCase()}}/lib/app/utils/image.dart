import 'dart:convert';
import 'dart:typed_data';

abstract class ImageHelper {
  static Uint8List? base64Decode(String base64Text) {
    try {
      return base64.decode(base64Text);
    } catch (e) {
      return null;
    }
  }
}
