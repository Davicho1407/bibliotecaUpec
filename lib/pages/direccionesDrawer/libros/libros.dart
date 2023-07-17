import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/card_information.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/information_book.dart';

class Libros extends StatefulWidget {
  const Libros({super.key});

  @override
  State<Libros> createState() => _LibrosState();
}

class _LibrosState extends State<Libros> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _editorialController = TextEditingController();
  final TextEditingController _materiaController = TextEditingController();
  List<QueryDocumentSnapshot> _resultados = [];
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

  Future<void> buscarLibro({
    String? titulo,
    String? autor,
    String? editorial,
    String? materia,
    String? descripcion,
    String? imagen_portada,
    String? libroUrl,
  }) async {
    final CollectionReference librosCollection =
        FirebaseFirestore.instance.collection('libros');

    QuerySnapshot querySnapshot;
    try {
      if (titulo != null ||
          autor != null ||
          editorial != null ||
          materia != null ||
          descripcion != null ||
          imagen_portada != null ||
          libroUrl != null) {
        Query query = librosCollection;

        if (titulo != null) {
          query = query.where('titulo',
              isGreaterThanOrEqualTo: titulo,
              isLessThanOrEqualTo: titulo + '\uf8ff');
        }
        if (autor != null) {
          query = query.where('autor',
              isGreaterThanOrEqualTo: autor,
              isLessThanOrEqualTo: autor + '\uf8ff');
        }
        if (editorial != null) {
          query = query.where('editorial',
              isGreaterThanOrEqualTo: editorial,
              isLessThanOrEqualTo: editorial + '\uf8ff');
        }
        if (materia != null) {
          query = query.where('materia',
              isGreaterThanOrEqualTo: materia,
              isLessThanOrEqualTo: materia + '\uf8ff');
        }
        if (descripcion != null) {
          query = query.where('descripcion',
              isGreaterThanOrEqualTo: descripcion,
              isLessThanOrEqualTo: descripcion + '\uf8ff');
        }
        if (imagen_portada != null) {
          query = query.where('imagen_portada',
              isGreaterThanOrEqualTo: imagen_portada,
              isLessThanOrEqualTo: imagen_portada + '\uf8ff');
        }
        if (libroUrl != null) {
          query = query.where('pdfUrl',
              isGreaterThanOrEqualTo: libroUrl,
              isLessThanOrEqualTo: libroUrl + '\uf8ff');
        }
        querySnapshot = await query.get();
      } else {
        querySnapshot = await librosCollection.get();
      }
      setState(() {
        _resultados = querySnapshot.docs;
      });
    } catch (e) {
      print('Error al buscar el libro: $e');
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _editorialController.dispose();
    _materiaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Libros",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.tealAccent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                  'Rellene los campos para establecer una busqueda más exacta'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tituloController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _autorController,
                      decoration: InputDecoration(labelText: 'Autor'),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _editorialController,
                      decoration: InputDecoration(labelText: 'Editorial'),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _materiaController,
                      decoration: InputDecoration(labelText: 'Materia'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      splashColor: Colors.white,
                      color: Colors.greenAccent,
                      onPressed: () {
                        buscarLibro(
                          titulo: _tituloController.text.isNotEmpty
                              ? _tituloController.text
                              : null,
                          autor: _autorController.text.isNotEmpty
                              ? _autorController.text
                              : null,
                          editorial: _editorialController.text.isNotEmpty
                              ? _editorialController.text
                              : null,
                          materia: _materiaController.text.isNotEmpty
                              ? _materiaController.text
                              : null,
                        );
                      },
                      child: Text(
                        'Buscar',
                        style: TextStyle(fontSize: 18),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _resultados.length,
                    itemBuilder: (context, index) {
                      String titulo = _resultados[index]['titulo'];
                      String autor = _resultados[index]['autor'];
                      String materia = _resultados[index]['materia'];
                      String editorial = _resultados[index]['editorial'];
                      String descripcion = _resultados[index]['descripcion'];
                      String imagenportada =
                          _resultados[index]['imagen_portada'];
                      String libroUrl = _resultados[index]['pdfUrl'];
                      return GestureDetector(
                        onDoubleTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InformationBook(
                                        titulo: titulo,
                                        autor: autor,
                                        materia: materia,
                                        editorial: editorial,
                                        descripcion: descripcion,
                                        imagenportada: imagenportada,
                                        libroUrl: libroUrl,
                                      )));
                        },
                        child: CardsInformation(
                          titulo: titulo,
                          autor: autor,
                          materia: materia,
                          imagenportada: imagenportada,
                        ),
                      );
                    })),
          ],
        ));
  }
}
