import 'package:flutter/material.dart';

class ActualizacionContenido extends StatefulWidget {
  const ActualizacionContenido({super.key});

  @override
  State<ActualizacionContenido> createState() => _ActualizacionContenidoState();
}

class _ActualizacionContenidoState extends State<ActualizacionContenido> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/fondo_contenido.png'), // Ruta de la imagen de fondo
          fit: BoxFit.cover, // Ajuste de la imagen en el contenedor
        ),
      ),
    );
  }
}
