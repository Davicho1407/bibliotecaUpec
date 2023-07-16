import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:upec_library_bloc/services/passwordReset.dart';

class OlvideContrasePage extends StatefulWidget {
  const OlvideContrasePage({super.key});

  @override
  State<OlvideContrasePage> createState() => _OlvideContrasePageState();
}

class _OlvideContrasePageState extends State<OlvideContrasePage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este es un requisito obligatorio'
        : null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  final PasswordReset _reset = PasswordReset();
  void recuperarPass() async {
    try {
      _reset.passwordReset(_emailController.text);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        text:
            'Se ha enviado un link para restablecer su contraseña! Revisa tu email',
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('El error fue:  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5BDDAB),
              Color(0xFFACEDD3)
            ], // Colores degradados
            begin: Alignment.topLeft, // Punto inicial del degradado
            end: Alignment.bottomRight, // Punto final del degradado
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 650,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 225,
                      height: 225,
                      child: Image.asset("assets/logo.png")),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Introduce el correo electrónico para poder regenerar tu contraseña: ",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SafeArea(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent, width: 4),
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Email',
                                fillColor: Colors.white),
                            validator: validator),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      splashColor: Colors.cyanAccent,
                      color: Colors.greenAccent,
                      child: Text(
                        'Recuperar contraseña',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          recuperarPass();
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
