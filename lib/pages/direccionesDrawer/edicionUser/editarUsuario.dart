import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
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
  String imagenUrl = '';

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
            imagenUrl = data['imagen'];
            print("La imagen es: $imagenUrl");
          });
        } else {
          print('El documento no existe.');
        }
      }, onError: (e) => print('Error en conseguir los documentos: $e'));
    }
  }

  ImageProvider _getImageProvider(String imageUrl) {
    try {
      return NetworkImage(imageUrl);
    } catch (e) {
      print('Error al cargar la imagen: $e');
      // Aquí puedes manejar la excepción, como mostrar una imagen de reemplazo o una imagen de error.
      // Por ejemplo:
      return AssetImage('assets/img/user.png');
    }
  }

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
              const SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white.withOpacity(0.1),
                backgroundImage: _getImageProvider(imagenUrl),
              ),
              const SizedBox(
                height: 40,
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
                                      useSafeArea: true,
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          elevation: 0.4,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.9),
                                          title: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'Actualiza tus datos',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          content: const EditarUser(),
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

  ///////////////////////Parte de subir la imagen
  String imageName = '';
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  ////////////////////////Conexion con firebase
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  String collectionName = 'profileImage';
  String uploadPathFirestore = '';

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference = storageRef
        .ref()
        .child(collectionName)
        .child(uid!)
        .child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          '\t' +
          event.totalBytes.toString());
    });
    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      uploadPathFirestore = uploadPath;

      ///Aqui guardo el link de la imagen en cloud firestore
      if (uploadPath.isNotEmpty) {
        firestoreRef
            .collection('usuarios')
            .doc(uid)
            .update({"imagen": uploadPath}).then(
                (value) => _showMessage('Link insertado en Firestore'));
      } else {
        _showMessage('Ocurrio un error mientras subia la imagen');
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }

//Conseguimos los datos del usuario que esta en firebase firestore
  String apodo = '';
  String nombre_completo = '';
  String nivel_de_carrera = '';
  String imagenUrl = '';

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
            imagenUrl = data['imagen'];
            print("La imagen es: $imagenUrl");
          });
        } else {
          print('El documento no existe.');
        }
      }, onError: (e) => print('Error en conseguir los documentos: $e'));
    }
  }

  @override
  void initState() {
    getDatosID();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      imageName == ""
                          ? Container()
                          : Text(
                              'La imagen seleccionada es:̀ ${imageName}',
                              textAlign: TextAlign.center,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            try {
                              imagePicker();
                              print(imagePicker());
                            } catch (e) {
                              print('El error es: $e');
                            }
                          },
                          child: Text('Selecciona una imagen')),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Si desea cambiar los datos, puede realizaro llenando los siguientes campos: ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Nombre update
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                    controller: _firstNameController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 4),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        hintText: '$apodo',
                                        fillColor: Colors.white),
                                    validator: validator),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Nombre completo
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                    controller: _nombreCompletoController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 4),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        hintText: '${nombre_completo}',
                                        fillColor: Colors.white),
                                    validator: validator),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              //Nivel de carrera completo
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                    controller: _nivelCarreraController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 4),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        hintText: '${nivel_de_carrera}',
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                          child: Text(
                                        'Guardar datos',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ))),
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ==
                                        true) {
                                      setState(() {
                                        sentDatos();
                                        _uploadImage();
                                      });
                                    }
                                  }),
                            ],
                          )),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
