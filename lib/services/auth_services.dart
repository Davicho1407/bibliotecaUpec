import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Ingresar con google
  signInWithGoogle() async {
    //Inicia la interacción
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // Obtener los detalles
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //Crear una nueva credencial
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //Ingresar
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
