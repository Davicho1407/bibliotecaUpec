import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String apodo = '';
  String nombre_completo = '';
  String nivel_de_carrera = '';

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
            apodo = data['nombre'];
            nombre_completo = data['nombre_completo'];
            nivel_de_carrera = data['nivel_de_carrera'];
          });
        } else {
          print('El documento no existe.');
        }
      }, onError: (e) => print('Error en conseguir los documentos: $e'));
    }
  }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'profileImage/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Link: $urlDownload');
    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              if (pickedFile != null)
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.circular(75)),
                  child: Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              Container(
                transform: Matrix4.translationValues(40, -20, 0),
                child: IconButton(
                    onPressed: () {
                      selectFile();
                      uploadFile();
                      // selectImage();
                      // saveImage();
                    },
                    icon: Icon(Icons.add_a_photo)),
              ),
              const SizedBox(
                height: 15,
              ),
              buildProgress(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Información de perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Usuario: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [Text('$apodo')],
                              )
                            ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Nombre Completo: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [Text('$nombre_completo')],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Nivel de carrera: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [Text('$nivel_de_carrera')],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
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
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.greenAccent),
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white),
                                                elevation: MaterialStateProperty
                                                    .all<double>(10.0),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                'Cerrar',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
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
  final _nombreCompletoController = TextEditingController();
  final _nivelCarreraController = TextEditingController();

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
          'nombre_completo': _nombreCompletoController.text,
          'nivel_de_carrera': _nivelCarreraController.text,
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
                    //Nombre completo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _nombreCompletoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 4),
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Nombre Completo',
                              fillColor: Colors.white),
                          validator: validator),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    //Nivel de carrera completo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _nivelCarreraController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 4),
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Nivel de carrera',
                              fillColor: Colors.white),
                          validator: validator),
                    ),
                    //Boton de guardar
                    SizedBox(
                      height: 40,
                    ),
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
