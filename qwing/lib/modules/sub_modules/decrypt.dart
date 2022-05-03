import 'dart:convert';
import 'package:crypto/crypto.dart';

class Decrypt {
  Decrypt(String password, String hashed) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha512.convert(bytes).toString();
    //print("Digest as hex string: $digest \n");

    //print("Hashed from db: \n" + hashed);

    identical(digest, hashed) ? print("Correct Password") : ("Wrong Password");
    /*
    String local =
        "754a6ed2890dc7b919507a82cf893ce4afcce5c19428709710c4e3b68a06fcf5eebbe43a41a49a9a6c73a331dc5eda015ea84dd47adb941fb4c0f227d4bf482d";
    String db =
        "754a6ed2890dc7b919507a82cf893ce4afcce5c19428709710c4e3b68a06fcf5eebbe43a41a49a9a6c73a331dc5eda015ea84dd47adb941fb4c0f227d4bf482d";
    print(identical(local, db));
    */
  }
}
