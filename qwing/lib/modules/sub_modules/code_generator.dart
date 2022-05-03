import 'dart:convert';
import 'package:crypto/crypto.dart';

class Password {
  Password(String password) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha512.convert(bytes);
    print("Digest as hex string: $digest \n");

    var tempPassword = password;
    var bytes2 = utf8.encode(tempPassword);
    var digest2 = sha512.convert(bytes2);
    print("Digest as hex string: $digest2 \n");

    digest == digest2
        ? print("Correct Password")
        : print("Something went wrong");
    //uncomment this for registration
    /*
    for (final hashString in [
      r'$5$zQUCjEzs9jnrRdCK$dbo1i9WjQjbUwOC4JCRAZHpfd31Dh676vI0L6w0dZw1',
      d1.toString()
    ]) {
      // Parse the crypt string: this extracts the type, rounds and salt
      // hash needs to be the same as "eyong password test"
      final h = Crypt(hashString);

      bool waitTime = h.match(password);

      if (waitTime) {
        h.match(password) ? return print('Success: Correct Value: $password') : null;
      }
      if (waitTime) {
        !h.match(password) ? print("Wrong password") : null;
      }
    }
    */
  }
}
