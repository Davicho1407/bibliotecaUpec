import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService {
  FirebaseAuthService() {
    initializeFirebaseApp();
  }

  void initializeFirebaseApp() async {
    await Firebase.initializeApp();
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      print('Error en la autenticacion: $e');
      throw e;
    }
  }
}
