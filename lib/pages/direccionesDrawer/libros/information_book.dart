import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class InformationBook extends StatefulWidget {
  final String titulo;
  final String autor;
  final String materia;
  final String editorial;
  final String descripcion;
  final String imagenportada;
  final String libroUrl;
  const InformationBook({
    super.key,
    required this.titulo,
    required this.autor,
    required this.materia,
    required this.editorial,
    required this.descripcion,
    required this.imagenportada,
    required this.libroUrl,
  });

  @override
  State<InformationBook> createState() => _InformationBookState();
}

class _InformationBookState extends State<InformationBook> {
  bool isBookFavorite = false;

  String? titulofavoritolibro;
  String? autorfavoritolibro;
  String? materiafavoritolibro;
  String? imagefavoritolibro;

  Future<void> saveFavoriteBook(String titulo, String autor, String materia,
      String imagefavoritolibro) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('titulofavoritolibro', titulo);
    await preferences.setString('autorfavoritolibro', autor);
    await preferences.setString('materiafavoritolibro', materia);
    await preferences.setString('imagefavoritolibro', imagefavoritolibro);

    setState(() {
      titulofavoritolibro = titulo;
      autorfavoritolibro = autor;
      materiafavoritolibro = materia;
    });
  }

  Future<void> descargarPDF(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final String fileName = 'libro001.pdf'; // Asigna un nombre al archivo

      final Directory directorio = await getApplicationDocumentsDirectory();
      final File file = File('${directorio.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFView(
            filePath: file.path,
          ),
        ),
      );
    } catch (e) {
      print('Algo ocurrio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Material(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Información del libro",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.tealAccent,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: SizedBox(
                  height: height * 0.8,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: height * 0.7,
                              width: width * 0.92,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.80),
                                  ]),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 180,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          NetworkImage(widget.imagenportada))),
                            ),
                          )),
                      Positioned(
                          top: 45,
                          left: 190,
                          child: SizedBox(
                            height: 170,
                            width: 190,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(widget.titulo,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 140,
                        left: 20,
                        width: width * 0.92,
                        height: 190,
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        top: 250,
                        left: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    text: 'Autor:   ',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.autor,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black54))
                                    ])),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    text: 'Materia:   ',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.materia,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black54))
                                    ])),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    text: 'Editorial:   ',
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.editorial,
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black54))
                                    ])),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Descripcion: ',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: height * 0.17,
                              width: width * 0.78,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  widget.descripcion,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              isBookFavorite =
                                  !isBookFavorite; // Cambiar el estado de favorito/no favorito al hacer clic
                              if (isBookFavorite) {
                                saveFavoriteBook(widget.titulo, widget.autor,
                                    widget.materia, widget.imagenportada);
                              } else {
                                // Si deseas eliminar las preferencias al dejar de ser favorito, puedes llamar a una función deleteFavoriteBook() en lugar de saveFavoriteBook() aquí.
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: Icon(
                              size: 70,
                              Icons.favorite,
                              color: isBookFavorite
                                  ? Colors.red
                                  : Colors.grey.shade100,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            descargarPDF(widget.libroUrl);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(
                              size: 70,
                              Icons.download,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
