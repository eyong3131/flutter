import 'dart:convert';
import 'package:crypto/crypto.dart';

//#13 Decrypt
class Decrypt {
  Decrypt(String password, String hashed) {
    //#13.1 plain text being encoded as utf8
    //#13.2 utf8 encoded text is now being converted into sha512
    //#13.2 unlike the crypt package that has built-in comparison function
    // but are terribly bad at performance,
    // crypt needs to be first get the hash from remote db and convert the
    // plain text to utf8 -> sha512 and locally check if they are identical.
    var bytes = utf8.encode(password);
    var digest = sha512.convert(bytes).toString();

    // replace the print function to a proper function
    identical(digest, hashed) ? print("Correct Password") : ("Wrong Password");
  }
}
