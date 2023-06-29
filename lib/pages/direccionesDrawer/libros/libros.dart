import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/card_information.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/filtroBusqueda.dart';

class Libros extends StatefulWidget {
  const Libros({super.key});

  @override
  State<Libros> createState() => _LibrosState();
}

class _LibrosState extends State<Libros> {
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
            Text('Hola'),
            Container(padding: EdgeInsets.all(20), child: FiltroBusqueda()),
            CardsInformation(
                titulo: 'titulo', autor: 'autor', materia: 'materia')
          ],
        ));
  }
}
