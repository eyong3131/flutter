import 'dart:convert';
import 'package:crypto/crypto.dart';

//#14 Password encryption
class Password {
  Password(String password) {
    //#14.1 we haven't tested any form of encryption other than SHA protocol,
    // so by default we used the only protocol we already know
    // to read more about the encryption method used please visit
    // https://pub.dev/packages/crypto
    var bytes = utf8.encode(password);
    var digest = sha512.convert(bytes);
    print("Digest as hex string: $digest \n");
  }
}
