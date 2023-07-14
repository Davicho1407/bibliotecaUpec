import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/dise%C3%B1o_general_widget.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/nuevoContenido.dart';

class FondoContenido extends StatelessWidget {
  const FondoContenido({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/fondo_contenido.png'), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Ajuste de la imagen en el contenedor
          ),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Nuevo Contenido',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  height: 800,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                          transform: Matrix4.translationValues(-5, 0, 0),
                          child: VistaWidgets()),
                      Container(
                        transform: Matrix4.translationValues(170, -200, 0),
                        child: VistaWidgets(),
                      ),
                      Container(
                          transform: Matrix4.translationValues(-5, -150, 0),
                          child: VistaWidgets()),
                      Container(
                        transform: Matrix4.translationValues(170, -350, 0),
                        child: VistaWidgets(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
