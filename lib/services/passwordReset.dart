import 'package:firebase_auth/firebase_auth.dart';

class PasswordReset {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> passwordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('El error fue: $e');
    }
  }
}
