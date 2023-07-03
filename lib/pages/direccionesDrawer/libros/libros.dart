import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/card_information.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/filtroBusqueda.dart';

class Libros extends StatefulWidget {
  const Libros({super.key});

  @override
  State<Libros> createState() => _LibrosState();
}

class _LibrosState extends State<Libros> {
  TextEditingController _tituloController = TextEditingController();
  List<QueryDocumentSnapshot> _resultados = [];

  Future<void> buscarLibroPorTitulo([String? titulo]) async {
    final CollectionReference librosCollection =
        FirebaseFirestore.instance.collection('libros');

    QuerySnapshot querySnapshot;

    if (titulo != null) {
      querySnapshot =
          await librosCollection.where('titulo', isEqualTo: titulo).get();
    } else {
      querySnapshot = await librosCollection.get();
    }

    setState(() {
      _resultados = querySnapshot.docs;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Busca por titulo'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_tituloController.text.isEmpty) {
                    buscarLibroPorTitulo();
                  } else {
                    buscarLibroPorTitulo(_tituloController.text);
                  }
                },
                child: Text('Buscar')),
            ElevatedButton(
                onPressed: () {
                  buscarLibroPorTitulo();
                },
                child: Text('Mostrar todos')),
            Expanded(
                child: ListView.builder(
                    itemCount: _resultados.length,
                    itemBuilder: (context, index) {
                      String titulo = _resultados[index]['titulo'];
                      String autor = _resultados[index]['autor'];
                      return CardsInformation(
                          titulo: titulo, autor: autor, materia: '');
                    })),
          ],
        ));
  }
}
