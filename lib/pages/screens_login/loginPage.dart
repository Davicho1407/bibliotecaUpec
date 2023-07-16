import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/paginaBody.dart';

import 'dart:async';

import 'package:upec_library_bloc/pages/screens_login/olvidarContrase%C3%B1a.dart';
import 'package:upec_library_bloc/pages/screens_login/resgistroCuenta.dart';
import 'package:upec_library_bloc/services/auth_services.dart';
import 'package:upec_library_bloc/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  String? validator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este es un requisito obligatorio'
        : null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5BDDAB), Color(0xFFACEDD3)], // Colores degradados
          begin: Alignment.topLeft, // Punto inicial del degradado
          end: Alignment.bottomRight, // Punto final del degradado
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 225, height: 225, child: Image.asset("assets/logo.png")),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: height * 0.75,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(25),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            text: 'Bienvenido a ',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'MyLibraryUpec',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.greenAccent))
                            ])),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      child: SafeArea(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.greenAccent,
                                                width: 4),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        hintText: 'Email',
                                        fillColor: Colors.white),
                                    validator: validator,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //Password Controller
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: _isObscure,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(_isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.greenAccent,
                                                width: 4),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        hintText: 'Contraseña',
                                        fillColor: Colors.white),
                                    validator: validator,
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const BtnGoogle()
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BtnIniciarSesion(
                        email: _emailController.text,
                        password: _passwordController.text,
                        formkey: _formKey),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BtnDireccion(
                                  nombre: "Olvide mi contraseña?",
                                  ruta: OlvideContrasePage())
                            ],
                          ),
                        ),
                        SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BtnDireccion(
                                  nombre: "Registrarse?", ruta: RegistroPage())
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BtnGoogle extends StatefulWidget {
  const BtnGoogle({super.key});

  @override
  State<BtnGoogle> createState() => _BtnGoogleState();
}

class _BtnGoogleState extends State<BtnGoogle> {
  bool _isPressed = false;

  Future<void> autenticacionUsuario() async {
    try {
      AuthService().signInWithGoogle();
      bool exitoso = true;

      if (exitoso) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaginaBody()));
      }
    } catch (e) {
      print('Ocurrio un error durante la autenticación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: _isPressed
                    ? Colors.greenAccent.shade200
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/iconGoogle.png",
                        width: 40,
                      )
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Continuar con Google")],
                  )
                ],
              ),
            ),
            onTapDown: (_) {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
            },
            onTap: () {
              autenticacionUsuario();
            }));
  }
}

///////////////////////////////////////////////////////

class BtnIniciarSesion extends StatefulWidget {
  final String email;
  final String password;
  final GlobalKey<FormState> formkey;

  const BtnIniciarSesion({
    super.key,
    required this.email,
    required this.password,
    required this.formkey,
  });
  @override
  State<BtnIniciarSesion> createState() => _BtnIniciarSesionState();
}

class _BtnIniciarSesionState extends State<BtnIniciarSesion> {
  // final usuario = TextEditingController();
  // final password = TextEditingController();

  bool _isPressed = false;

  final FirebaseAuthService _authService = FirebaseAuthService();
  void signIn() async {
    try {
      await _authService.signIn(widget.email, widget.password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaBody(),
        ),
      );
      // Reemplaza la pantalla actual con la pantalla de inicio
    } catch (e) {
      print('Error en la autenticacion con los requisitos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color:
                _isPressed ? Colors.grey.shade200 : Colors.greenAccent.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          if (widget.formkey.currentState?.validate() == true) {
            signIn();
          }
        },
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
      ),
    );
  }
}

class BtnDireccion extends StatefulWidget {
  final String nombre;

  final Widget ruta;

  const BtnDireccion({super.key, required this.nombre, required this.ruta});
  @override
  State<BtnDireccion> createState() => _BtnDireccionState();
}

class _BtnDireccionState extends State<BtnDireccion> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        child: AnimatedContainer(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          color: Colors.white,
          duration: Duration(milliseconds: 200),
          child: Text(
            widget.nombre,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _isPressed ? Colors.grey : Colors.black,
            ),
          ),
        ),
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.ruta),
          );
        },
      ),
    );
  }
}
