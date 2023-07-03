import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/edicionUser/conexion_storage.dart';
import 'package:upec_library_bloc/pages/paginaBody.dart';

class EditarUsuario extends StatefulWidget {
  const EditarUsuario({super.key});

  @override
  State<EditarUsuario> createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  String nombre = '';

  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  void initState() {
    getDatosID();

    super.initState();
  }

//Conseguimos los datos del usuario que esta en firebase firestore
  Future getDatosID() async {
    if (uid != null) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('usuarios').doc(uid);

      documentReference.get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            nombre = data['nombre'];
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PaginaBody()));
          }),
        ),
        title: const Text(
          "Editar Usuario",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditarUsuario()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage('assets/img/user.png'),
              ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {},
                  )),
              SizedBox(
                height: 25,
              ),
              Text(
                'Información de perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    transform: Matrix4.translationValues(0, 20, 0),
                    width: 500,
                    height: 175,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Usuario: ' '$nombre',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
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
                    'Editar usuario',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Actualiza tus datos',
                              textAlign: TextAlign.center,
                            ),
                            content: EditarUser(),
                            actions: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.greenAccent),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation:
                                      MaterialStateProperty.all<double>(10.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Cerrar',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditarUser extends StatefulWidget {
  const EditarUser({super.key});

  @override
  State<EditarUser> createState() => _EditarUserState();
}

class _EditarUserState extends State<EditarUser> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();

  String? validator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este es un requisito obligatorio'
        : null;
  }

  Future sentDatos() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .update({
          'nombre': _firstNameController.text,
        });
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          text:
              'Se ha actualizado sus datos, refresque la pantalla para observar sus cambios',
        );
        print('Datos actualizados correctamente');
      }
    } catch (e) {
      print('Error al actualizar los datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    //Nombre update
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _firstNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 4),
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Usuario',
                              fillColor: Colors.white),
                          validator: validator),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Apellido update
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   child: TextFormField(
                    //       controller: _emailController,
                    //       keyboardType: TextInputType.text,
                    //       decoration: InputDecoration(
                    //           enabledBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Colors.white),
                    //               borderRadius: BorderRadius.circular(12)),
                    //           focusedBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(
                    //                   color: Colors.greenAccent, width: 4),
                    //               borderRadius: BorderRadius.circular(12)),
                    //           hintText: 'Email',
                    //           fillColor: Colors.white),
                    //       validator: validator),
                    // ),
                    SizedBox(
                      height: 40,
                    ),

                    //Boton de guardar

                    MaterialButton(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Text(
                              'Guardar datos',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ))),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true) {
                            setState(() {
                              sentDatos();
                            });
                          }
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
