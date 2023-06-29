import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class ConexionCloudFirestore {
  Future<void> register(
    String email,
    String password,
    String firstName,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Si el usuario se crea correctamente, llama a la función que guarda los datos en Firestore
      if (userCredential.user != null) {
        addUserDetails(userCredential.user!.uid, firstName, email, password);
        // Cerrar sesión
        await _auth.signOut();
        // Navegar a la página de inicio de sesión
      }
    } on FirebaseAuthException catch (e) {
      print('Error de firebase: $e');
    } catch (e) {
      print("Error al crear el usuario: $e");
    }
  }

  Future<void> addUserDetails(
      String userId, String firstName, String email, String password) async {
    try {
      await db
          .collection('usuarios')
          .doc(userId)
          .set({'nombre': firstName, 'email': email, 'contraseña': password});
      print("Datos guardados correctamente en Firestore.");
    } catch (e) {
      print("Error al guardar los datos en Firestore: $e");
    }
  }
}
