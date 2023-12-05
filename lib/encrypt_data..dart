import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptData {
  final encrypter = Encrypter(AES(generateKey()));
  final iv = IV.fromUtf8(dotenv.env['IV']!);

  String encryptData(String data) {
    return encrypter.encrypt(data, iv: iv).base64;
  }

  String decryptData(String encryptedData) {
    return encrypter.decrypt64(encryptedData, iv: iv);
  }

  static Key generateKey() {
    final keyString = dotenv.env['SECRET_KEY']!;
    return Key(Uint8List.fromList(base64Url.decode(keyString)));
  }
}
