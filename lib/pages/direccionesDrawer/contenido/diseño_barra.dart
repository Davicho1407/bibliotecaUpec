import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/diseño_general_widget.dart';

class ContenidoRow extends StatefulWidget {
  const ContenidoRow({super.key});

  @override
  State<ContenidoRow> createState() => _ContenidoRowState();
}

class _ContenidoRowState extends State<ContenidoRow> {
  bool contenidoVisible = false;
  double containerHeight = 100.0; // Tamaño inicial del Container
  String imagenMostrar = 'assets/img/libro_abierto.png';
  String imagenOcultar = 'assets/img/libro_cerrado.png';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(color: HexColor('#dfdfce')),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Noticias de evento',
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          contenidoVisible = !contenidoVisible;
                          containerHeight = contenidoVisible
                              ? 200.0
                              : 100.0; // Cambiar el tamaño del Container
                        });
                      },
                      child: Image.asset(
                        contenidoVisible ? imagenOcultar : imagenMostrar,
                        width: 75.0,
                        height: 75.0,
                      )),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300), // Duración de la animación
              height: containerHeight, // Tamaño del Container
              child: Visibility(
                visible: contenidoVisible,
                child: Column(
                  children: [
                    Container()
                    // Otros widgets que se mostrarán u ocultarán dentro del Container
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
