import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/asistente_bookia/assistent.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/chat/api/chat_api.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/edicionUser/editarUsuario.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/libros.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/notificaciones.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/nuevoContenido.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/redSocial.dart';
import 'package:upec_library_bloc/pages/screens_login/loginPage.dart';
import 'package:upec_library_bloc/services/auth_services.dart';

class PaginaBody extends StatefulWidget {
  const PaginaBody({super.key});

  @override
  State<PaginaBody> createState() => _PaginaBodyState();
}

class _PaginaBodyState extends State<PaginaBody> {
  @override
  void initState() {
    getDatosID();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser?.uid;
  String usuario = '';
  String email = '';
  String imagenUrlReference = '';
  Future getDatosID() async {
    if (user != null) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('usuarios').doc(user);

      documentReference.get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            usuario = data['nombre'];
            email = data['email'];
          });
        } else {
          print('El documento no existe.');
        }
      }, onError: (e) => print('Error en conseguir los documentos: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Inicio',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/fondo_userDrawer.jpg'))),
            padding: EdgeInsets.all(0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("$usuario", style: TextStyle(color: Colors.black)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("$email", style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.chat),
                  title: Text("Nuevo Chat"),
                  onTap: () {
                    final ChatApi chatApi;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AssistentBookia()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.content_copy),
                  title: Text("Nuevo Contenido"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NuevoContenido()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text("Libros"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Libros()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.telegram),
                  title: Text("Red Social"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RedSocial()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text("Notificaciones"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notificaciones()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text("Editar usuario"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditarUsuario()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Salir"),
                  onTap: () async {
                    try {
                      AuthService().signOut();
                      //Navegar a la pantalla de inicio de sesión
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      )),
      body: _PaginaBienvenidad(),
    );
  }
}

class _PaginaBienvenidad extends StatefulWidget {
  const _PaginaBienvenidad({super.key});

  @override
  State<_PaginaBienvenidad> createState() => __PaginaBienvenidadState();
}

class __PaginaBienvenidadState extends State<_PaginaBienvenidad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageIndicatorContainer(
        indicatorColor: Colors.white,
        indicatorSelectorColor: Colors.black,
        length: 4,
        child: PageView(
          children: [
            MenuDinamico(
                title: 'Bienvenid@ a MyLibraryUpec!!!',
                imagepath: 'assets/buho.png',
                tamanoImage: 300,
                descripcion:
                    'MyLibraryUpec es tu biblioteca virtual diseñada para facilitar tu acceso a libros, materiales de estudio, asistencia virtual y más a los estudiantes de Agropecuaria.'),
            MenuDinamico(
                title: 'Descubre los recursos de estudio',
                imagepath: 'assets/libro_celular.png',
                tamanoImage: 300,
                descripcion:
                    'Encuentra libros digitales como guía para tu aprendizaje.'),
            MenuDinamico(
                title: 'Explora las novedades',
                imagepath: 'assets/novedades.png',
                tamanoImage: 150,
                descripcion:
                    'Matente al día con lanzamiento de nuevos libros, noticias y actualizaciones.'),
            MenuDinamico(
                title: 'Asistente Virtual Dinámico',
                imagepath: 'assets/asistente.png',
                tamanoImage: 250,
                descripcion:
                    'Esta aquí para ayudarte en tu camino académico. Haz preguntas, solicita recomendaciones de libros, obten información sobre temas específicos y más.')
          ],
        ),
      ),
    );
  }
}

class MenuDinamico extends StatelessWidget {
  final String title;
  final String imagepath;
  final double tamanoImage;
  final String descripcion;

  const MenuDinamico(
      {super.key,
      required this.title,
      required this.imagepath,
      required this.descripcion,
      required this.tamanoImage});
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(title,
                style: TextStyle(fontSize: 35, fontFamily: 'Lobster'),
                textAlign: TextAlign.center),
            Container(
              width: tamanoImage,
              padding: EdgeInsets.all(5),
              child: Image.asset(imagepath),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Text(descripcion,
                  style: TextStyle(fontSize: 18, fontFamily: 'Bogart'),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    ));
  }
}
